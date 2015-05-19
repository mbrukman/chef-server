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

%% Test generators that setup and run the tests
contains_admin_group_test_() ->
  [
    { "Reports that admins group is found", contains_admin_group_true() },
    { "Reports that admins group is not found", contains_admin_group_false() }
  ].

check_admin_group_removal_test_() ->
  %% Use foreach so that the setup and teardown are run for each tests
  %% so that any mocks/stubs are reset
  { foreach, fun setup/0, fun teardown/1, [fun check_admin_group_removal_tests/1] }.


%% Setup/teardown functions.
%% Not used for all tests, only those that need mocking/stubbing
setup() ->
  %% Use meck to mock out the module, but set passthrough
  %% so only those functions called with meck:expect are mocked
  %% mocking/stubbing
  meck:new(oc_chef_authz_acl_constraints, [passthrough]).

teardown(_) ->
  meck:unload(oc_chef_authz_acl_constraints).


%% contains_admin_group tests
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


%% check_admin_group_removal_tests
check_admin_group_removal_tests(_) ->
  [
    { "Check admin group removal returns admins group is not removed", check_admin_group_removal_not_removed() }
  ].

check_admin_group_removal_not_removed() ->
  meck:expect(oc_chef_authz_acl_constraints, contains_admin_group, fun(_Group) -> false end),
  [
    %% CurrentGroup doesn't contain the admins group
    ?_assertEqual(not_removed, oc_chef_authz_acl_constraints:check_admin_group_removal([], [])),
    %% CurrentGroup contains admins group, NewGroup also contains admin group
    ?_assertEqual(not_removed, oc_chef_authz_acl_constraints:check_admin_group_removal([<<"admins">>], [<<"admins">>]))
  ].

