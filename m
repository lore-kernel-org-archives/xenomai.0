References: <local-431ba0ad-f9d5@nylas-mail.nylas.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <14d1a056-a83d-b811-17c6-7caab06ec731@xenomai.org>
Date: Tue, 5 Dec 2017 14:37:39 +0100
MIME-Version: 1.0
In-Reply-To: <local-431ba0ad-f9d5@nylas-mail.nylas.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Xenomai 3.0.6 - affinity rtdm task to to specific
 core CPU
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Piotr Piorkowski <qba100@gmail.com>, "Xenomai xenomai.org" <Xenomai@xenomai.org>

On 12/04/2017 06:44 PM, Piotr Piorkowski wrote:
>    Hi
> 
>    Can I affinity rtdm task to to specific core CPU ? If I can, how should
>    I do it ?
> 

There is no provision for this in the RTDM API unfortunately.

You have the option of hacking with the Cobalt internal API from your
RTDM task implementation this way:

void rtdm_task(void *arg)
{
	struct task_struct *p = current;

	xnthread_relax(0);
	set_cpus_allowed_ptr(p, cpumask_of(cpu_number));
	xnthread_harden();

	/* your code */
}

-- 
Philippe.

