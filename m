Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012003.outbound.protection.outlook.com [52.101.66.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D212C3D5245
	for <xenomai@lists.linux.dev>; Fri, 20 Mar 2026 21:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774043042; cv=fail; b=ph3isDTfQsR4a/qtyjZqZgJTy8PtggiGRyXmh1CwHuQa1tW+lVR+tu2DrHKyZDvLKC+3c4YMxcwg2fril4Ou+De3LuQlR++sQWA8byujzhi0M8c4Ra1TEfu3sqg3FQfQtbkn5yXL7vP/8U1qbmhnj6U9e6HJCeo25I5ZlGJCWM0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774043042; c=relaxed/simple;
	bh=0/u1am9JDZaldB+7yXhSK1x4nxJJ0z7gTgmXP5s6Soo=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=pvHFVpI+4vI2M1TWSDK0ED6ph9lnRD9eqvY1vyghkiAliqgOyMjL2SFREZaBaOpBdAnLUhaPQbreMKusWC74T7zulDwgopCjJmK+mWjTyYX5OXbvNZzFLO/7jWrY4ppSurQaF/DIxoS+JwaSYf+tdSc9nhy9PpvVfw2blBLQnhk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=VwhHyXvk; arc=fail smtp.client-ip=52.101.66.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="VwhHyXvk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AnjynkVIL07f0BYJk/QV95hlwBgP8lpyBr6G+xEZKEh2uVeEEm5CwDPMneZZrv/bdMrF48ESdmQHuElRYMKyzL49tyXdsPdCvG5a0IpkSSxxWRB56rXpB8/nnSu87OjpWx+WlmrZAh+iCZkLeUdVc6kMjdn1iY6qremDLzApMiEgj+gru9LboZn886xnxljFFFaSGPTSklJGyPdG/cobOyWKnx6bUh1WEADwJOkj/r7ADY3lhHear0ZdeiDEJjh4otUdJjjlFqdN2PQlARvD65BwY9J7yKr4/QPacfSuyA7pFLvoIEk37ckvlxUxl19UT8yP8FsfghvIPQNox+tnIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uMHeaTRH6LYI94wfn1dUo6mMWBz0hO/2lrdiHdOdtUE=;
 b=d9uPlgW/mcVANXT1II5HjcnjVEOooLSH1XargzQOi/9Fes2SXazOFKwQuZSun/26L70HOKo9wfNXab88trlIu2Wtomg5XFmjzbYVqbNEkrxJtka8jlbhhM1gowpu7brkOKzDB9lq5AVtvP7nAMkpB7Yol+fnZVJNZsX1oN4KPXAT4mhYxKjhuHllhFHmjsU9mCLMzjbb6awyUonyzZ55v2K5+z53pG7hxChINSQdHVgHoXY9MKeHBmAbRSLp4FBuB6oosBu3tp0ZC8T4CkzwDIly4bAbAVC7PK+6yL6rEAMJ5d9nCNJQmBYQABgwzizMgMP7HziCyKa4MuosILxkFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uMHeaTRH6LYI94wfn1dUo6mMWBz0hO/2lrdiHdOdtUE=;
 b=VwhHyXvkQlz5bCz8fFwzF+Oyi2UXuQRueQW+TavaMMjt5eC4v5FC6qNWp8hDdy//O/valXxoO6A5e12dabafw6jhvqFqwfBmDTVkE5sbhjFc8MJ7k2PMy0lg1eDW0YKsW7+Ferc+VhDyawxxGWLwthi4iadcRhq6cKQpqu847+yCCpzvFHaRhZ5auwzv2+JWN7sqfoez/zGjMfW2iW0Tml/PQ3tUAoQu7NgoOO0BU7jqfn4eKavRL1sRrXeIdCfsrLKCp7A66YWKvIc79R+0YxNGhNfsJbtlqXaSb/y/qOIejXYWAZKBq0wMKVFWHuwQ1zR42Wa5JICQAQaqZ9KWtA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by AM7PR10MB3157.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:105::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.20; Fri, 20 Mar
 2026 21:43:58 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8%5]) with mapi id 15.20.9723.022; Fri, 20 Mar 2026
 21:43:58 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: rpm@xenomai.org,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [PATCH libevl v2] evl-test: add stress command support for background load testing
Date: Fri, 20 Mar 2026 22:43:50 +0100
Message-ID: <20260320214350.2211809-1-tobias.schaffner@siemens.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0231.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e9::11) To AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:3dd::5)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4992:EE_|AM7PR10MB3157:EE_
X-MS-Office365-Filtering-Correlation-Id: 51de483f-9207-40fc-6691-08de86c9ca5b
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|55112099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	trjOuFW52b/1+gRxtJ9e7SjHWe51o7sQ2d3Ps73tyLIek3N0ERK8iXnEzSeQe760jBEenzxpvrTVFegRGR3eMnRU6VytxtHgsZUIVxLsygypeFKqPUKNocE2MAE/aKEVXTMux5rlYhRDzXb0Lu9jqNUiPsb5o64G89bFbVy7v6qXofjwgv4oh5SUMI84MZqdXn2mwUeGonO89ovAJa6Fq8KHIZL9BfrAr/1ZZxsbjCyd5m75/+CxwwRL3kTW09uZhFFZP6iP1DD4wrAegpNvebTj55fYZzKbLJpjFs4eTYcGLNqYJJqqBohIqd30suLTuspPX7iKT6NhATLQuLupGoyJNnr5d96HSwAM8w8fLkE7AFVvDyBKvA7sMyXCFUV2Khr3ys63jd7vGIIOqV3qL2ggcVrSxDokNdmUjOjFld1LTugA3R4kQxwSTQGvuDhffPERq5wIBdHFO+8gZktYnzzPGmQ1IwSWiVADFzQZ+BBHJbfXWsNRk8ZvY2+cZdAbb5i2B64zcIGqAUuJyzy/ZCJhHvF0sUe2svpkyJcozf2j3rW2kwg5NHk8JJLQShllJkGcENslHdk4TTTCNA7e2KzJ4ubArruwPz7FxmMmAXX+AG6oU/WprpJS0L2d49NCuZpeYTLKs5tIFhVe6vOjqjVw6vf86rwdxgXwdcjhvfZpNYwklZT2x8Zovnwsi1j5nx98OnMSuoax0XzrJzX30UDOGsI1qctvlbo5WVYHlzM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(55112099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZaFpNKEjeOLGUVG3FiVbvy0NL1qYgZjg0JHE98aTGxNBbLlOaI8D3uMlJqOP?=
 =?us-ascii?Q?7+A1b0eeqPoi8L65HBwAun4HxBNWGpbcSB7fqGOjKvbIXYmGrGpssede8syX?=
 =?us-ascii?Q?1rJR+6ILA2Yr19+nN3Ey/ZjWFoED+CvadyMSGqE0JV1RuEUiLo4ceL/cC6yd?=
 =?us-ascii?Q?C9jXrETphXlLU9emb1m/Mc7SpEH7ZZkE8YNlfC6geXaHXNOcJaVT5MWwKf0g?=
 =?us-ascii?Q?LqOGjuSqMecaAT3jEms8+9sBcS9JQSI1GQfwJsV5IZW+DUB0YLwdze1vicpl?=
 =?us-ascii?Q?pJKigSIDrKzov2sJOzhicmCQhvzIV4AwsZz6eAP4j4NAGEq8JURCwqGPjAR1?=
 =?us-ascii?Q?rrbuQiSQvw8afcB5tLnkf1iUq8k8D9W+H1+4hjM3mkGg49nJAr9V6mEXiMkB?=
 =?us-ascii?Q?RWCeQAWSGzibH1e2dqaXfIhkriD3SuRRhctR/eoZHbB58jnq73OI/cYUW/FM?=
 =?us-ascii?Q?P9TEO6y2cYppK7tE5JYycT1ziO3GNp6l47S58QaTdprsonwtBBekdbf/Yanj?=
 =?us-ascii?Q?aj0P1BYMENBwqcBetCwfDWdUqn8nUAJ1WoLE7c90AwQExi22Ixz5zr7zEuCE?=
 =?us-ascii?Q?rZmGGlRmqqxt5BQi7E+/zOm1xUN1wNA0WNp1xUJmLUuUHUykaPcmwvQTzpr5?=
 =?us-ascii?Q?N55pYS/8I5WHcwGfXGfiToLG20TEdAN6/LTEXvgOhfVPZL8r2tlu43xJsLU6?=
 =?us-ascii?Q?wVFWn+X6dyBJebYs0cOrMBikdTHFb9hUv07ymNHH5FKKR8wBVKXdsHdU5/ei?=
 =?us-ascii?Q?52JZIFytVQy61ueOSdrOqw0mUPfUQ9GB7QMDMynZ3Ey79hh9WwMep+K0pWQq?=
 =?us-ascii?Q?WwQQZfYRPmZt+OwskrriyYeB81iYyGXIuoyKWf4B8jFWBwteshN67gg27s26?=
 =?us-ascii?Q?8hOYoBJTtnVIcXP0rGND6pgB8uKMVc/bnfl1F08nmJ8f1xAg4kJR3MnbtZzs?=
 =?us-ascii?Q?oUtMpxV4P4tfe4nMzTXCzjS9AM6G9hmk8vE7VMecZEob4DvoGo0IbCH9Y1qA?=
 =?us-ascii?Q?B/St0R/x245f0pwS55iBGL8CLa1qoUsaz5I7PRcwyIQwaTKi08aFWMzNV18s?=
 =?us-ascii?Q?jHlTkDZLKM67iBeQmb+YRifmzs2O4hMgmr0E41I7h1iT6Yem4ePpEzdmqSVE?=
 =?us-ascii?Q?mLJ5Hdx4rB0tRCiD7LYDFmzjSHGHcGD+GrBPypO5MNtcW0kd0JimNQDRA+ax?=
 =?us-ascii?Q?zmOa47IvIZDlZOkcWi22YlGoTJKt/fl909gRoqm474sSzOxB/dEoNwYxtUZk?=
 =?us-ascii?Q?XHXuxRRTYAWZfKsvJeMHGpQEkuALbSPuzqTBvL918rYeeREm8nZzlVE2TdAH?=
 =?us-ascii?Q?r7YX+wiUXnJFRkgbBGyJv2L9iRoGj4nCIxH2V2nqMl9Q5QdpiRP0D3/ETmuq?=
 =?us-ascii?Q?ZmJQJUM9e0w7Mk6Gp4fk+h7cF6o/QqT7E58e5NlViKgkgiwzg7UmIdhYiJMH?=
 =?us-ascii?Q?M8lrO04S3QAV448fb/077Zy8Z6gW6eqi2lhP1EkyKvvisdRhKQQZkF8iufbL?=
 =?us-ascii?Q?wN3+UgRKi5OkKzTo0JOKNVtLaciqT9B7G7Fko1LnWWRuq00QqMBjfPvtCIrB?=
 =?us-ascii?Q?Ca1tVCuk5fuXTvOEqrjf19LWqtq6uQW0A56GP/e5t/0ddV+pAhT002bdSljk?=
 =?us-ascii?Q?+ciDqZbWXW7grhmXXpq3K6f3vbspgVi4ppzWtLna8POG+M0cbTdKei+tflgH?=
 =?us-ascii?Q?xDJeVD1QX8vmFNbC5GqFo6V7u4gTCqDztYDlBW4dif4hTJiwgWW3Ii4d+97e?=
 =?us-ascii?Q?zWvjT9Db/fA39On1JawAvqIxu86YCek=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51de483f-9207-40fc-6691-08de86c9ca5b
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2026 21:43:58.1940
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I8+MHgPxOk/lB6Z7Ky91yu+MC5Rh48g0mnJ6Yo6CEzETradjmWVWf0oYhEIYqe4j3X9IUQsUrzL5+uuRMMZMzdSG1/RjeLHHvJySNIRNeKc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3157

Add the ability to run a stress command (e.g. stress-ng) in the
background during test execution via the new -s option. This allows
testing EVL functionality under system load.

The stress command runs in its own process group (via setsid) to ensure
clean termination of all child processes, and is automatically stopped
when tests complete or the script exits normally or via signals.

The stress command output is redirected to /dev/null by default but can
be send to a file using the "EVL_TEST_STRESS_OUTPUT" environment
variable.

Usage example:
  evl-test -s "stress-ng --vm 2 --vm-bytes 1G --cpu 4" -k

Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
---
 utils/evl-test | 30 +++++++++++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/utils/evl-test b/utils/evl-test
index 6e1edc3..28f2aed 100644
--- a/utils/evl-test
+++ b/utils/evl-test
@@ -7,7 +7,7 @@ if test \! -d $EVL_TESTDIR; then
 fi
 
 usage() {
-   echo >&2 "usage: $(basename $1) [-l][-L][-k][-r][-h] [test-list]"
+   echo >&2 "usage: $(basename $1) [-l][-L][-k][-r][-h][-s] [test-list]"
 }
 
 help=false
@@ -18,6 +18,8 @@ full_path=false
 test_args=false
 test_arg_list=
 test_list=
+stress_cmd=
+stress_pid=
 
 while test $# -gt 0
 do
@@ -37,6 +39,8 @@ do
 	    -L) full_path=true;
 		do_list=true;
 		shift;;
+	    -s) stress_cmd="$2";
+		shift 2;;
 	    --) test_args=true
 		shift;;
 	    -@) echo "run the EVL tests"
@@ -49,6 +53,28 @@ do
     fi
 done
 
+stop_stress() {
+    trap - EXIT INT TERM
+    if test -n "$stress_pid"; then
+        kill -TERM -$stress_pid 2>/dev/null
+        # Give the process up to one second to terminate gracefully
+        for i in $(seq 10); do kill -0 -$stress_pid 2>/dev/null || break; sleep 0.1; done
+        kill -KILL -$stress_pid 2>/dev/null
+        wait $stress_pid 2>/dev/null
+    fi
+    exit
+}
+
+start_stress() {
+    if test -n "$stress_cmd"; then
+        trap 'stop_stress' EXIT INT TERM
+        stress_output="${EVL_TEST_STRESS_OUTPUT:-/dev/null}"
+        setsid $stress_cmd </dev/null >"$stress_output" 2>&1 &
+        stress_pid=$!
+        sleep 1 # Give stress command time to start
+    fi
+}
+
 if test x$help = xtrue; then
    usage $0
    exit 0
@@ -73,6 +99,8 @@ if test x$do_list = xtrue; then
    exit 0
 fi
 
+start_stress
+
 result=0
 
 while : ; do
-- 
2.43.0

