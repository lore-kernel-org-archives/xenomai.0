References: <ff158e3f-0693-6852-2ddd-4a6c82417d20@sigmatek.at>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <847665d6-bb8a-3e58-7f01-f4422cbea254@xenomai.org>
Date: Thu, 2 Mar 2017 18:53:12 +0100
MIME-Version: 1.0
In-Reply-To: <ff158e3f-0693-6852-2ddd-4a6c82417d20@sigmatek.at>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] rt_task_sleep returned -EPERM
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Wolfgang Netbal <wolfgang.netbal@sigmatek.at>, Xenomai Mailing List <xenomai@xenomai.org>

On 03/02/2017 03:53 PM, Wolfgang Netbal wrote:
> 
> I am calling function rt_task_sleep and the returncode is -EPERM
> In the xenomai api I found that this is returned from a task that cannot
> sleep
> see below
> http://xenomai.org/documentation/xenomai-2.6/html/api/group__task.html#gad5225e5fb8d583fbdfa5299f322b8366
> 
> 
> I can exclude that I am in an interrupt or a non-realtime because all my
> tasks are shadowed.
> But how can I have a scheduler locked ?
> 

No, the only plausible reason is really that the calling task is not a
Xenomai task. You may want to double-check this; if
CONFIG_XENO_OPT_DEBUG_NUCLEUS is enabled, you should see a warning
appearing in the kernel log when the call is denied.

-- 
Philippe.

