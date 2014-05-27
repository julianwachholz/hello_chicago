
APP=hello_chicago
ERL=erl
ERL_LIBS=deps
REBAR=rebar
DIALYZER=dialyzer
DIALYZER_APPS=kernel stdlib sasl inets crypto public_key ssl

.PHONY: deps rel test test-eunit test-fun dialyze

all: app

app: deps
	@env ERL_LIBS=$(ERL_LIBS) $(REBAR) compile

deps: $(REBAR)
	@$(REBAR) get-deps

clean: $(REBAR)
	@$(REBAR) clean

rel: app
	@cd rel && ../$(REBAR) generate

dist: dist/$(APP).tar.gz
dist/$(APP).tar.gz: rel
	@mkdir -p dist && tar zcf dist/$(APP).tar.gz -C rel $(APP)

test: test-eunit test-fun

test-eunit: $(REBAR) app
	@$(REBAR) boss c=test_eunit

test-fun: $(REBAR) app
	@$(REBAR) boss c=test_functional

dialyze: .$(APP).plt
	@$(DIALYZER) --src src --plt .$(APP).plt -Werror_handling \
		-Wrace_conditions -Wunmatched_returns # -Wunderspecs

.$(APP).plt:
	@$(DIALYZER) --build_plt --output_plt .$(APP).plt --apps $(DIALYZER_APPS)
