
ERL=erl
REBAR=rebar

all:
	@$(REBAR) get-deps
	@$(REBAR) compile

clean:
	@$(REBAR) clean

