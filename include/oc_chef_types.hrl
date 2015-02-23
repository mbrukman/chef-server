%% -*- erlang-indent-level: 4;indent-tabs-mode: nil; fill-column: 92 -*-
%% ex: ts=4 sw=4 et
%% @author Stephen Delano <stephen@opscode.com>
%% Copyright 2013 Opscode, Inc. All Rights Reserved.
%% Copyright 2014 Chef, Inc. All Rights Reserved.

-record(oc_chef_container, {
          id,
          authz_id,
          org_id,
          name,
          last_updated_by,
          created_at,
          updated_at
         }).

-record(oc_chef_group, {
          id,
          for_requestor_id,
          authz_id,
          org_id,
          name,
          last_updated_by,
          created_at,
          updated_at,
          clients = [],
          users = [],
          groups = [],
          auth_side_actors = [],
          auth_side_groups = []
          }).

-record(oc_chef_policy, {
          id,
          name,
          policy_group,
          org_id,
          authz_id,
          last_updated_by,
          serialized_object
          }).

-record(oc_chef_cookbook_artifact, {
          id,
          org_id,
          name,
          authz_id,
          version_identifiers :: [ Identifier::binary() ]
         }).

-record(oc_chef_cookbook_artifact_version, {
          id,
          identifier,
          metadata,
          serialized_object,
          created_at,
          created_by,
          org_id,
          name,
          authz_id,
          checksums :: [ Checksum::binary() ]
         }).

-record(oc_chef_organization, {
          id,
          authz_id,
          name,
          full_name,
          assigned_at,
          last_updated_by,
          created_at,
          updated_at
         }).

-record(oc_chef_org_user_association, {
          org_id,
          user_id,
          user_name, % Not part of the table but retrieved via join
          last_updated_by,
          created_at,
          updated_at
         }).

-record(oc_chef_org_user_invite, {
          id,
          org_id,
          org_name,  % Not  part of table - retrieved via join
          user_id,
          user_name, % Not  part of table - retrieved via join
          last_updated_by,
          created_at,
          updated_at
         }).
