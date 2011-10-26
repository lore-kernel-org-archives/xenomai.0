Message-ID: <4EA7E037.2090305@domain.hid>
Date: Wed, 26 Oct 2011 12:25:59 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <patchbomb.1318861189@domain.hid>
	<c2a2a1a093ea9baee853.1318861193@domain.hid>
In-Reply-To: <c2a2a1a093ea9baee853.1318861193@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] [PATCH 4 of 4] psos: fix compiler warning: cprio
 could be used uninitialized
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Thomas De Schampheleire <patrickdepinguin+xenomai@domain.hid>
Cc: xenomai@xenomai.org

On 10/19/2011 09:35 AM, Thomas De Schampheleire wrote:
> Assign default 1 to satisfy compiler (tested with gcc 4.4.3)
>
> Signed-off-by: Thomas De Schampheleire<thomas.de.schampheleire@domain.hid>
> Signed-off-by: Ronny Meeus<ronny.meeus@domain.hid>
>
> ---
>   lib/psos/task.c |  4 ++--
>   1 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/lib/psos/task.c b/lib/psos/task.c
> --- a/lib/psos/task.c
> +++ b/lib/psos/task.c
> @@ -247,7 +247,7 @@ u_long t_create(const char *name, u_long
>   	pthread_attr_t thattr;
>   	struct syncstate syns;
>   	struct service svc;
> -	int ret, cprio;
> +	int ret, cprio = 1;
>   	char short_name[5];
>
>   	ret = check_task_priority(prio,&cprio);
> @@ -414,7 +414,7 @@ u_long t_resume(u_long tid)
>   u_long t_setpri(u_long tid, u_long newprio, u_long *oldprio_r)
>   {
>   	struct psos_task *task;
> -	int ret, cprio;
> +	int ret, cprio = 1;
>
>   	task = get_psos_task_or_self(tid,&ret);
>   	if (task == NULL)
>

Looks like 4.4.3 is wrong, 4.4.4+ does it better and does not choke. 
Just to make sure the optimizer is given a chance to see the truth, 
could you try without this patch, but with tagging check_task_priority() 
as inline instead, with --disable-debug, then with --enable-debug=full 
switches?

TIA,

-- 
Philippe.

