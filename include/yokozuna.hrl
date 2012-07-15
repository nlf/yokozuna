%% -------------------------------------------------------------------
%%
%% Copyright (c) 2012 Basho Technologies, Inc.  All Rights Reserved.
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
%% -------------------------------------------------------------------

%%%===================================================================
%%% Records
%%%===================================================================

-record(yz_index_cmd, {
          doc :: doc(),
          index :: string(),
          req_id :: non_neg_integer()
         }).

-record(yz_search_cmd, {
          qry :: term(),
          req_id :: non_neg_integer()
         }).

-record(solr_vclocks, {
          more=false :: boolean(),
          continuation :: base64() | none,
          pairs :: [{DocID::binary(), VClock::base64()}]
         }).

%% A reference to a merkle tree.
-record(tree_ref, {
          index :: string(),
          name :: tree_name(),
          pid :: pid(),
          ref :: reference()
         }).

%%%===================================================================
%%% Types
%%%===================================================================

-type name() :: atom().
-type value() :: term().
-type field() :: {name(), value()}.
-type fields() :: [field()].
-type doc() :: {doc, fields()}.
-type base64() :: base64:ascii_string().
-type solr_vclocks() :: #solr_vclocks{}.
-type iso8601() :: string().
-type tree_name() :: atom().
-type tree_ref() :: #tree_ref{}.

%% N value
-type n() :: pos_integer().
%% Number of partitions
-type q() :: pos_integer().
%% Partition
-type p() :: non_neg_integer().
%% Logical Partition
-type lp() :: pos_integer().
%% Distance between LPs
-type dist() :: non_neg_integer().
%% Mapping from logical partition to partition
-type logical_idx() :: [{lp(), p()}].


%%%===================================================================
%%% Macros
%%%===================================================================

-define(DEBUG(Fmt, Args), error_logger:error_msg(Fmt ++ "~n", Args)).
-define(ERROR(Fmt, Args), error_logger:error_msg(Fmt ++ "~n", Args)).

-define(INT_TO_BIN(I), list_to_binary(integer_to_list(I))).

-define(YZ_DEFAULT_SOLR_PORT, "8983").
-define(YZ_EVENTS_TAB, yz_events_tab).
-define(YZ_ENTROPY_DATA_FIELD, '_yz_ed').
-define(YZ_ROOT_DIR, app_helper:get_env(?YZ_APP_NAME, root_dir, "data/yz")).
-define(YZ_PRIV, code:priv_dir(?YZ_APP_NAME)).
-define(YZ_CORE_CFG_FILE, "config.xml").
-define(YZ_SCHEMA_FILE, "schema.xml").
-define(YZ_INDEX_CMD, #yz_index_cmd).
-define(YZ_SEARCH_CMD, #yz_search_cmd).
-define(YZ_APP_NAME, yokozuna).
-define(YZ_SVC_NAME, yokozuna).
-define(YZ_VNODE_MASTER, yokozuna_vnode_master).
