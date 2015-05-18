%% @author Mark Mzyk <mm@chef.io>
%%
%% Copyright 2015 Chef Software, Inc.
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

-module(oc_chef_authz_acl_constraints_tests).

-compile([export_all]).

-include_lib("eunit/include/eunit.hrl").

contains_admin_group_test_() ->
  [
    { "Reports that admins group is found", contains_admin_group_true() },
    { "Reports that admins group is not found", contains_admin_group_false() }
  ].

contains_admin_group_true() ->
  [
    ?_assertEqual(true, oc_chef_authz_acl_constraints:contains_admin_group([<<"admins">>])),
    ?_assertEqual(true, oc_chef_authz_acl_constraints:contains_admin_group([<<"admins">>, <<"another_group">>]))
  ].

contains_admin_group_false() ->
  [
    ?_assertEqual(false, oc_chef_authz_acl_constraints:contains_admin_group([])),
    ?_assertEqual(false, oc_chef_authz_acl_constraints:contains_admin_group([<<"another_group">>]))
  ].
