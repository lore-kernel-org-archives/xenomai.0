From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH v3] drivers/autotune: Fix UBSAN warnings
Message-ID: <655b1875-e712-262a-86ca-569f84d0df77@siemens.com>
Date: Fri, 26 Jul 2019 19:47:53 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>, Philippe Gerum <rpm@xenomai.org>

The calculations in add_sample can overflow into undefined behavior - or
even generate wrong results. Address that by giving related fields in
tuner_state more space. This requires one division to be modeled with
xnarch_llimd for 32-bit target archs.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kernel/drivers/autotune/autotune.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/drivers/autotune/autotune.c b/kernel/drivers/autotune/autotune.c
index 2629bf9d47..77ec9a1a21 100644
--- a/kernel/drivers/autotune/autotune.c
+++ b/kernel/drivers/autotune/autotune.c
@@ -57,8 +57,8 @@ struct tuner_state {
 	int min_lat;
 	int max_lat;
 	int prev_mean;
-	int prev_sqs;
-	int cur_sqs;
+	long long prev_sqs;
+	long long cur_sqs;
 	unsigned int sum;
 	unsigned int cur_samples;
 	unsigned int max_samples;
@@ -435,7 +435,7 @@ static inline void build_score(struct gravity_tuner *tuner, int step)
 
 	n = state->cur_samples;
 	tuner->scores[step].pmean = state->sum / n;
-	variance = n > 1 ? state->cur_sqs / (n - 1) : 0;
+	variance = n > 1 ? xnarch_llimd(state->cur_sqs, 1, n - 1) : 0;
 	tuner->scores[step].stddev = int_sqrt(variance);
 	tuner->scores[step].minlat = state->min_lat;
 	tuner->scores[step].gravity = tuner->get_gravity(tuner);
-- 
2.16.4

