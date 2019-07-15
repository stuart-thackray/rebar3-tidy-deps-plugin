-module(rebar_github_resource).

-behaviour(rebar_resource).

-export([lock/2
        ,download/3
        ,needs_update/2
        ,make_vsn/1]).

-record(app_info_t, {name               :: binary() | undefined,
                     app_file_src       :: file:filename_all() | undefined,
                     app_file_src_script:: file:filename_all() | undefined,
                     app_file           :: file:filename_all() | undefined,
                     original_vsn       :: binary() | undefined,
                     parent=root        :: binary() | root,
                     app_details=[]     :: list(),
                     applications=[]    :: list(),
                     deps=[]            :: list(),
                     profiles=[default] :: [atom()],
                     default=dict:new() ,
                     opts=dict:new()    ,
                     dep_level=0        :: integer(),
                     dir                :: file:name(),
                     out_dir            :: file:name(),
                     ebin_dir           :: file:name(),
                     source             :: string() | tuple() | checkout | undefined,
                     is_lock=false      :: boolean(),
                     is_checkout=false  :: boolean(),
                     valid              :: boolean() | undefined,
                     project_type      ,
                     is_available=false :: boolean()}).

lock(Dir, Source) ->
    rebar_git_resource:lock(#app_info_t{dir = Dir}, untidy_dep(Source)).

download(Dir, Source, State) ->
    rebar_git_resource:download(#app_info_t{dir = Dir}, untidy_dep(Source), State).

needs_update(Dir, Source) ->
    rebar_git_resource:make_vsn(#app_info_t{dir = Dir}, untidy_dep(Source)).

make_vsn(Dir) ->
    rebar_git_resource:make_vsn(Dir).

-spec untidy_dep(tuple()) -> [tuple()].
untidy_dep({github, Repo, Vsn}) ->
    {git, "https://github.com/" ++ Repo, Vsn}.
