
ERL=erl
REBAR=rebar

.PHONY: all clean test

all:
	@$(REBAR) get-deps
	@$(REBAR) compile

clean:
	@$(REBAR) clean


# Testing
test:
	@$(REBAR) boss c=test_eunit
	@$(REBAR) boss c=test_functional

test-eunit:
	@$(REBAR) boss c=test_eunit

test-fun:
	@$(REBAR) boss c=test_functional
