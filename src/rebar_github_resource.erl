-module(rebar_github_resource).

-behaviour(rebar_resource).

-export([lock/2
        ,download/3
        ,needs_update/2
        ,make_vsn/1]).

lock(Dir, Source) ->
    rebar_legacy_git_resource:lock(Dir, untidy_dep(Source)).

download(Dir, Source, State) ->
    rebar_legacy_git_resource:download(Dir, untidy_dep(Source), State).

needs_update(Dir, Source) ->
    rebar_legacy_git_resource:make_vsn(Dir, untidy_dep(Source)).

make_vsn(Dir) ->
    rebar_legacy_git_resource:make_vsn(Dir).

-spec untidy_dep(tuple()) -> [tuple()].
untidy_dep({github, Repo, Vsn}) ->
    {git, "https://github.com/" ++ Repo, Vsn}.
