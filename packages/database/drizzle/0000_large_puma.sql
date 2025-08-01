CREATE EXTENSION IF NOT EXISTS vector;

CREATE TABLE "activities" (
	"id" text PRIMARY KEY NOT NULL,
	"name" text NOT NULL,
	"short_overview" text,
	"type" text NOT NULL,
	"date" timestamp with time zone NOT NULL,
	"severity" text NOT NULL,
	"server_id" integer NOT NULL,
	"user_id" text,
	"item_id" text,
	"created_at" timestamp DEFAULT now() NOT NULL
);
--> statement-breakpoint
CREATE TABLE "items" (
	"id" text PRIMARY KEY NOT NULL,
	"server_id" integer NOT NULL,
	"library_id" text NOT NULL,
	"name" text NOT NULL,
	"type" text NOT NULL,
	"original_title" text,
	"etag" text,
	"date_created" timestamp with time zone,
	"container" text,
	"sort_name" text,
	"premiere_date" timestamp with time zone,
	"path" text,
	"official_rating" text,
	"overview" text,
	"community_rating" double precision,
	"runtime_ticks" bigint,
	"production_year" integer,
	"is_folder" boolean NOT NULL,
	"parent_id" text,
	"media_type" text,
	"width" integer,
	"height" integer,
	"series_name" text,
	"series_id" text,
	"season_id" text,
	"season_name" text,
	"index_number" integer,
	"parent_index_number" integer,
	"video_type" text,
	"has_subtitles" boolean,
	"channel_id" text,
	"location_type" text,
	"genres" text[],
	"primary_image_aspect_ratio" double precision,
	"primary_image_tag" text,
	"series_primary_image_tag" text,
	"primary_image_thumb_tag" text,
	"primary_image_logo_tag" text,
	"parent_thumb_item_id" text,
	"parent_thumb_image_tag" text,
	"parent_logo_item_id" text,
	"parent_logo_image_tag" text,
	"backdrop_image_tags" text[],
	"parent_backdrop_item_id" text,
	"parent_backdrop_image_tags" text[],
	"image_blur_hashes" jsonb,
	"image_tags" jsonb,
	"can_delete" boolean,
	"can_download" boolean,
	"play_access" text,
	"is_hd" boolean,
	"provider_ids" jsonb,
	"tags" text[],
	"series_studio" text,
	"people" jsonb,
	"raw_data" jsonb NOT NULL,
	"embedding" vector(1536),
	"processed" boolean DEFAULT false,
	"created_at" timestamp DEFAULT now() NOT NULL,
	"updated_at" timestamp DEFAULT now() NOT NULL
);
--> statement-breakpoint
CREATE TABLE "job_results" (
	"id" serial PRIMARY KEY NOT NULL,
	"job_id" varchar(255) NOT NULL,
	"job_name" varchar(255) NOT NULL,
	"status" varchar(50) NOT NULL,
	"result" jsonb,
	"error" text,
	"processing_time" integer,
	"created_at" timestamp DEFAULT now() NOT NULL
);
--> statement-breakpoint
CREATE TABLE "libraries" (
	"id" text PRIMARY KEY NOT NULL,
	"name" text NOT NULL,
	"type" text NOT NULL,
	"server_id" integer NOT NULL,
	"created_at" timestamp DEFAULT now() NOT NULL,
	"updated_at" timestamp DEFAULT now() NOT NULL
);
--> statement-breakpoint
CREATE TABLE "servers" (
	"id" serial PRIMARY KEY NOT NULL,
	"name" text NOT NULL,
	"url" text NOT NULL,
	"api_key" text NOT NULL,
	"last_synced_playback_id" bigint DEFAULT 0 NOT NULL,
	"local_address" text,
	"server_name" text,
	"version" text,
	"product_name" text,
	"operating_system" text,
	"startup_wizard_completed" boolean DEFAULT false NOT NULL,
	"open_ai_api_token" text,
	"auto_generate_embeddings" boolean DEFAULT false NOT NULL,
	"ollama_api_token" text,
	"ollama_base_url" text,
	"ollama_model" text,
	"embedding_provider" text,
	"sync_status" text DEFAULT 'pending' NOT NULL,
	"sync_progress" text DEFAULT 'not_started' NOT NULL,
	"sync_error" text,
	"last_sync_started" timestamp,
	"last_sync_completed" timestamp,
	"created_at" timestamp DEFAULT now() NOT NULL,
	"updated_at" timestamp DEFAULT now() NOT NULL
);
--> statement-breakpoint
CREATE TABLE "sessions" (
	"id" text PRIMARY KEY NOT NULL,
	"server_id" integer NOT NULL,
	"user_id" text,
	"item_id" text,
	"user_name" text NOT NULL,
	"user_server_id" text,
	"device_id" text,
	"device_name" text,
	"client_name" text,
	"application_version" text,
	"remote_end_point" text,
	"item_name" text,
	"series_id" text,
	"series_name" text,
	"season_id" text,
	"play_duration" integer,
	"start_time" timestamp with time zone,
	"end_time" timestamp with time zone,
	"last_activity_date" timestamp with time zone,
	"last_playback_check_in" timestamp with time zone,
	"runtime_ticks" bigint,
	"position_ticks" bigint,
	"percent_complete" double precision,
	"completed" boolean NOT NULL,
	"is_paused" boolean NOT NULL,
	"is_muted" boolean NOT NULL,
	"is_active" boolean NOT NULL,
	"volume_level" integer,
	"audio_stream_index" integer,
	"subtitle_stream_index" integer,
	"play_method" text,
	"media_source_id" text,
	"repeat_mode" text,
	"playback_order" text,
	"transcoding_audio_codec" text,
	"transcoding_video_codec" text,
	"transcoding_container" text,
	"transcoding_is_video_direct" boolean,
	"transcoding_is_audio_direct" boolean,
	"transcoding_bitrate" integer,
	"transcoding_completion_percentage" double precision,
	"transcoding_width" integer,
	"transcoding_height" integer,
	"transcoding_audio_channels" integer,
	"transcoding_hardware_acceleration_type" text,
	"raw_data" jsonb NOT NULL,
	"created_at" timestamp DEFAULT now() NOT NULL,
	"updated_at" timestamp DEFAULT now() NOT NULL
);
--> statement-breakpoint
CREATE TABLE "users" (
	"id" text PRIMARY KEY NOT NULL,
	"name" text NOT NULL,
	"server_id" integer NOT NULL,
	"last_login_date" timestamp with time zone,
	"last_activity_date" timestamp with time zone,
	"has_password" boolean DEFAULT false NOT NULL,
	"has_configured_password" boolean DEFAULT false NOT NULL,
	"has_configured_easy_password" boolean DEFAULT false NOT NULL,
	"enable_auto_login" boolean DEFAULT false NOT NULL,
	"is_administrator" boolean DEFAULT false NOT NULL,
	"is_hidden" boolean DEFAULT false NOT NULL,
	"is_disabled" boolean DEFAULT false NOT NULL,
	"enable_user_preference_access" boolean DEFAULT true NOT NULL,
	"enable_remote_control_of_other_users" boolean DEFAULT false NOT NULL,
	"enable_shared_device_control" boolean DEFAULT false NOT NULL,
	"enable_remote_access" boolean DEFAULT true NOT NULL,
	"enable_live_tv_management" boolean DEFAULT false NOT NULL,
	"enable_live_tv_access" boolean DEFAULT true NOT NULL,
	"enable_media_playback" boolean DEFAULT true NOT NULL,
	"enable_audio_playback_transcoding" boolean DEFAULT true NOT NULL,
	"enable_video_playback_transcoding" boolean DEFAULT true NOT NULL,
	"enable_playback_remuxing" boolean DEFAULT true NOT NULL,
	"enable_content_deletion" boolean DEFAULT false NOT NULL,
	"enable_content_downloading" boolean DEFAULT false NOT NULL,
	"enable_sync_transcoding" boolean DEFAULT true NOT NULL,
	"enable_media_conversion" boolean DEFAULT false NOT NULL,
	"enable_all_devices" boolean DEFAULT true NOT NULL,
	"enable_all_channels" boolean DEFAULT true NOT NULL,
	"enable_all_folders" boolean DEFAULT true NOT NULL,
	"enable_public_sharing" boolean DEFAULT false NOT NULL,
	"invalid_login_attempt_count" integer DEFAULT 0 NOT NULL,
	"login_attempts_before_lockout" integer DEFAULT 3 NOT NULL,
	"max_active_sessions" integer DEFAULT 0 NOT NULL,
	"remote_client_bitrate_limit" integer DEFAULT 0 NOT NULL,
	"authentication_provider_id" text DEFAULT 'Jellyfin.Server.Implementations.Users.DefaultAuthenticationProvider' NOT NULL,
	"password_reset_provider_id" text DEFAULT 'Jellyfin.Server.Implementations.Users.DefaultPasswordResetProvider' NOT NULL,
	"sync_play_access" text DEFAULT 'CreateAndJoinGroups' NOT NULL,
	"created_at" timestamp DEFAULT now() NOT NULL,
	"updated_at" timestamp DEFAULT now() NOT NULL
);
--> statement-breakpoint
ALTER TABLE "activities" ADD CONSTRAINT "activities_server_id_servers_id_fk" FOREIGN KEY ("server_id") REFERENCES "public"."servers"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "activities" ADD CONSTRAINT "activities_user_id_users_id_fk" FOREIGN KEY ("user_id") REFERENCES "public"."users"("id") ON DELETE set null ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "items" ADD CONSTRAINT "items_server_id_servers_id_fk" FOREIGN KEY ("server_id") REFERENCES "public"."servers"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "items" ADD CONSTRAINT "items_library_id_libraries_id_fk" FOREIGN KEY ("library_id") REFERENCES "public"."libraries"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "libraries" ADD CONSTRAINT "libraries_server_id_servers_id_fk" FOREIGN KEY ("server_id") REFERENCES "public"."servers"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "sessions" ADD CONSTRAINT "sessions_server_id_servers_id_fk" FOREIGN KEY ("server_id") REFERENCES "public"."servers"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "sessions" ADD CONSTRAINT "sessions_user_id_users_id_fk" FOREIGN KEY ("user_id") REFERENCES "public"."users"("id") ON DELETE set null ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "sessions" ADD CONSTRAINT "sessions_item_id_items_id_fk" FOREIGN KEY ("item_id") REFERENCES "public"."items"("id") ON DELETE set null ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "users" ADD CONSTRAINT "users_server_id_servers_id_fk" FOREIGN KEY ("server_id") REFERENCES "public"."servers"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
CREATE INDEX "items_embedding_idx" ON "items" USING hnsw ("embedding" vector_cosine_ops);