-- phpMyAdmin SQL Dump
-- version 2.11.9.4
-- http://www.phpmyadmin.net


SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";

--
-- Database: `thinktank`
--

-- --------------------------------------------------------

--
-- Table structure for table `follows`
--

CREATE TABLE IF NOT EXISTS `tt_follows` (
  `user_id` int(11) NOT NULL,
  `follower_id` int(11) NOT NULL,
  `last_seen` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  `active` int(11) NOT NULL default '1',
  PRIMARY KEY  (`user_id`,`follower_id`),
  KEY `active` (`active`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Table structure for table `instances`
--

CREATE TABLE IF NOT EXISTS `tt_instances` (
  `id` int(11) NOT NULL auto_increment,
  `twitter_user_id` int(11) NOT NULL,
  `twitter_username` varchar(255) collate utf8_bin NOT NULL,
  `last_status_id` bigint(11) default '0',
  `crawler_last_run` timestamp NOT NULL default CURRENT_TIMESTAMP,
  `last_page_fetched_replies` int(11) NOT NULL default '1',
  `last_page_fetched_tweets` int(11) NOT NULL default '1',
  `total_tweets_by_owner` int(11) default '0',
  `total_tweets_in_system` int(11) default '0',
  `total_replies_in_system` int(11) default NULL,
  `total_users_in_system` int(11) default NULL,
  `total_follows_in_system` int(11) default NULL,
  `earliest_tweet_in_system` datetime default NULL,
  `earliest_reply_in_system` datetime default NULL,
  `is_archive_loaded_replies` int(11) NOT NULL default '0',
  `is_archive_loaded_follows` int(11) NOT NULL default '0',
  `api_calls_to_leave_unmade_per_minute` decimal(11,1) NOT NULL default '2.0',
  `is_public` int(1) NOT NULL default '0',
  `is_active` int(1) NOT NULL default '1',
  PRIMARY KEY  (`id`),
  KEY `twitter_user_id` (`twitter_user_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Table structure for table `owners`
--

CREATE TABLE IF NOT EXISTS `tt_owners` (
  `id` int(20) NOT NULL auto_increment,
  `full_name` varchar(200) character set latin1 collate latin1_general_ci NOT NULL default '',
  `user_name` varchar(200) character set latin1 collate latin1_general_ci NOT NULL default '',
  `user_pwd` varchar(200) character set latin1 collate latin1_general_ci NOT NULL default '',
  `user_email` varchar(200) character set latin1 collate latin1_general_ci NOT NULL default '',
  `activation_code` int(10) NOT NULL default '0',
  `joined` date NOT NULL default '0000-00-00',
  `country` varchar(100) character set latin1 collate latin1_general_ci NOT NULL default '',
  `user_activated` int(1) NOT NULL default '0',
  `is_admin` int(1) NOT NULL default '0',
  `last_login` date NOT NULL default '0000-00-00',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `owner_instances`
--

CREATE TABLE IF NOT EXISTS `tt_owner_instances` (
  `id` int(20) NOT NULL auto_increment,
  `owner_id` int(10) NOT NULL,
  `instance_id` int(10) NOT NULL,
  `oauth_access_token` varchar(255) NOT NULL default '',
  `oauth_access_token_secret` varchar(255) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `tweets`
--

CREATE TABLE IF NOT EXISTS `tt_tweets` (
  `id` int(11) NOT NULL auto_increment,
  `status_id` bigint(11) NOT NULL,
  `author_user_id` int(11) NOT NULL,
  `author_username` varchar(50) collate utf8_bin NOT NULL,
  `author_fullname` varchar(50) collate utf8_bin NOT NULL,
  `author_avatar` varchar(255) collate utf8_bin NOT NULL,
  `tweet_text` varchar(160) collate utf8_bin NOT NULL,
  `tweet_html` varchar(255) collate utf8_bin NOT NULL,
  `source` varchar(255) collate utf8_bin NOT NULL,
  `pub_date` timestamp NOT NULL default '0000-00-00 00:00:00',
  `in_reply_to_user_id` int(11) default NULL,
  `in_reply_to_status_id` bigint(11) default NULL,
  `mention_count_cache` int(11) NOT NULL default '0',
  `in_retweet_of_status_id` bigint(11) default NULL,
  `retweet_count_cache` int(11) NOT NULL default '0',
  PRIMARY KEY  (`id`),
  UNIQUE KEY `status_id` (`status_id`),
  KEY `author_username` (`author_username`),
  KEY `pub_date` (`pub_date`),
  KEY `in_reply_to_user_id` (`in_reply_to_user_id`),
  KEY `author_user_id` (`author_user_id`),
  KEY `in_retweet_of_status_id` ( `in_retweet_of_status_id` ),
  FULLTEXT KEY `tweets_fulltext` (`tweet_text`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Table structure for table `tweet_errors`
--

CREATE TABLE IF NOT EXISTS `tt_tweet_errors` (
  `id` int(11) NOT NULL auto_increment,
  `status_id` bigint(20) NOT NULL,
  `error_code` int(11) NOT NULL,
  `error_text` varchar(255) collate utf8_bin NOT NULL,
  `error_issued_to_user_id` int(11) NOT NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `status_id` (`status_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE IF NOT EXISTS `tt_users` (
  `id` int(11) NOT NULL auto_increment,
  `user_id` int(11) NOT NULL,
  `user_name` varchar(255) collate utf8_bin NOT NULL,
  `full_name` varchar(255) collate utf8_bin NOT NULL,
  `avatar` varchar(255) collate utf8_bin NOT NULL,
  `location` varchar(255) collate utf8_bin default NULL,
  `description` text collate utf8_bin,
  `url` varchar(255) collate utf8_bin default NULL,
  `is_protected` tinyint(1) NOT NULL,
  `follower_count` int(11) NOT NULL,
  `friend_count` int(11) NOT NULL default '0',
  `tweet_count` int(11) NOT NULL,
  `last_updated` timestamp NOT NULL default CURRENT_TIMESTAMP,
  `found_in` varchar(100) collate utf8_bin default NULL,
  `last_post` timestamp NOT NULL default '0000-00-00 00:00:00',
  `joined` timestamp NOT NULL default '0000-00-00 00:00:00',
  `last_status_id` bigint(20) NOT NULL default '0',
  PRIMARY KEY  (`id`),
  UNIQUE KEY `user_id` (`user_id`),
  KEY `last_updated_user_id` (`last_updated`,`user_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Table structure for table `user_errors`
--

CREATE TABLE IF NOT EXISTS `tt_user_errors` (
  `id` int(11) NOT NULL auto_increment,
  `user_id` int(20) NOT NULL,
  `error_code` int(11) NOT NULL,
  `error_text` varchar(255) collate utf8_bin NOT NULL,
  `error_issued_to_user_id` int(11) NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `user_id` (`user_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Table structure for table `links`
--

CREATE TABLE IF NOT EXISTS `tt_links` (
  `id` int(11) NOT NULL auto_increment,
  `url` varchar(255) collate utf8_bin NOT NULL,
  `expanded_url` varchar(255) collate utf8_bin NOT NULL,
  `title` varchar(255) collate utf8_bin NOT NULL,
  `clicks` int(11) NOT NULL default '0',
  `status_id` bigint(11) NOT NULL,
  `is_image` tinyint(4) NOT NULL default '0',
  PRIMARY KEY  (`id`),
  KEY `status_id` (`status_id`),
  KEY `is_image` (`is_image`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
