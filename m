References: <561E4D93.4090803@xenomai.org>
 <145395888.622970.1444841737686.JavaMail.yahoo@mail.yahoo.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <561F5C37.9020602@xenomai.org>
Date: Thu, 15 Oct 2015 09:56:39 +0200
MIME-Version: 1.0
In-Reply-To: <145395888.622970.1444841737686.JavaMail.yahoo@mail.yahoo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] rt_heap_alloc size 0 - syscall 7 denied
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Frederik Bayart <frederik_bayart@yahoo.co.uk>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 10/14/2015 06:55 PM, Frederik Bayart wrote:
> However the biggest problem is the denied syscall :
> 
> [Xenomai] syscall <7> denied to sysregd[22217]
> 

This one is not an issue, it's merely debug noise. You can silence it
with this change; the result will be functionally the same, without the
scary warning.

diff --git a/lib/copperplate/regd/regd.c b/lib/copperplate/regd/regd.c
index 25bd7a5..5d69d83 100644
--- a/lib/copperplate/regd/regd.c
+++ b/lib/copperplate/regd/regd.c
@@ -538,7 +538,7 @@ int main(int argc, char *const *argv)

 	/* Force SCHED_OTHER. */
 	schedp.sched_priority = 0;
-	pthread_setschedparam(pthread_self(), SCHED_OTHER, &schedp);
+	__STD(pthread_setschedparam(pthread_self(), SCHED_OTHER, &schedp));

 	memset(&sa, 0, sizeof(sa));
 	sa.sa_handler = SIG_IGN;

-- 
Philippe.

