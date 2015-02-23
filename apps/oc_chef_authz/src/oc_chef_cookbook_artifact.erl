%% -*- erlang-indent-level: 4;indent-tabs-mode: nil; fill-column: 92 -*-
%% ex: ts=4 sw=4 et
%% @author Jean Rouge <jean@chef.io>
%% Copyright 2015 Chef Software, Inc. Some Rights Reserved.
%%
%% This file is provided to you under the Apache License,
%% Version 2.0 (the "License"); you may not use this file
%% except in compliance with the License.  You may obtain
%% a copy of the License at
%%
%%   http://www.apache.org/licenses/LICENSE-2.0
%%
%% Unless required by applicable law or agreed to in writing,
%% software distributed under the License is distributed on an
%% "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
%% KIND, either express or implied.  See the License for the
%% specific language governing permissions and limitations
%% under the License.
%%

-module(oc_chef_cookbook_artifact).

-include("../../include/chef_types.hrl").
-include("../../include/oc_chef_types.hrl").
-include_lib("mixer/include/mixer.hrl").

-behaviour(chef_object).

-mixin([{chef_object,[{default_fetch/2, fetch}]}]).

%% chef_object behaviour callbacks
-export([id/1,
         name/1,
         org_id/1,
         type_name/1,
         authz_id/1,
         create_query/0,
         update_query/0,
         delete_query/0,
         find_query/0,
         list_query/0,
         bulk_get_query/0,
         is_indexed/0,
         ejson_for_indexing/2,
         update_from_ejson/2,
         new_record/3,
         set_created/2,
         set_updated/2,
         fields_for_fetch/1,
         fields_for_update/1,
         update/2,
         list/2,
         record_fields/0,
         flatten/1]).

-export([exists_by_authz_id/1]).

id(#oc_chef_cookbook_artifact{id = Id}) ->
    Id.

name(#oc_chef_cookbook_artifact{name = Name}) ->
    Name.

org_id(#oc_chef_cookbook_artifact{org_id = OrgId}) ->
    OrgId.

type_name(#oc_chef_cookbook_artifact{}) ->
    oc_chef_cookbook_artifact.

authz_id(#oc_chef_cookbook_artifact{authz_id = AuthzId}) ->
    AuthzId.

create_query() ->
    %% created when creating a cookbook artifact version
    erlang:error(not_supported).

update_query() ->
    erlang:error(not_supported).

delete_query() ->
    erlang:error(not_supported).

find_query() ->
    find_cookbook_artifact_by_org_id_name.

list_query() ->
    erlang:error(not_supported).

bulk_get_query() ->
    erlang:error(not_supported).

is_indexed() ->
    false.

ejson_for_indexing(#oc_chef_cookbook_artifact{}, _EjsonTerm) ->
   erlang:error(not_supported).

update_from_ejson(#oc_chef_cookbook_artifact{}, _Ejson) ->
    erlang:error(not_supported).

new_record(_OrgId, _AuthzId, _Ejson) ->
    erlang:error(not_supported).

set_created(#oc_chef_cookbook_artifact{}, _ActorId) ->
    erlang:error(not_supported).

set_updated(#oc_chef_cookbook_artifact{}, _ActorId) ->
    erlang:error(not_supported).

fields_for_update(#oc_chef_cookbook_artifact{}) ->
    erlang:error(not_supported).

fields_for_fetch(#oc_chef_cookbook_artifact{org_id = OrgId,
                                            name = Name}) ->
    [OrgId, Name].

list(#oc_chef_cookbook_artifact{org_id = OrgId}, CallbackFun) ->
    CallbackFun({list_query(), [OrgId], rows}).

record_fields() ->
    record_info(fields, oc_chef_cookbook_artifact).

update(#oc_chef_cookbook_artifact{}, _CallbackFun) ->
	erlang:error(not_supported).

flatten(#oc_chef_cookbook_artifact{}) ->
    erlang:error(not_supported).

%% @doc Checks if a cookbook artifact with the given `AuthzId' exists
-spec exists_by_authz_id(binary()) -> boolean | {error, _Why}.
exists_by_authz_id(AuthzId) ->
    case chef_sql:select_rows({check_cookbook_artifact_exists_by_authz_id,
                               [AuthzId]}) of
        not_found -> false;
        [[{<<"authz_id">>, AuthzId}]] -> true;
        {error, _Why} = Error -> Error
    end.
