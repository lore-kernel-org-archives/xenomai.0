References: <DB6PR0701MB2456788DAE300E14759F9646B5E10@DB6PR0701MB2456.eurprd07.prod.outlook.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <2eb3cb3c-bbfd-32f1-0864-77749389813c@xenomai.org>
Date: Mon, 15 May 2017 12:39:09 +0200
MIME-Version: 1.0
In-Reply-To: <DB6PR0701MB2456788DAE300E14759F9646B5E10@DB6PR0701MB2456.eurprd07.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] rt_task_bind returns -EINVAL when not using
 --enable-smp
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Giulio Moro <g.moro@qmul.ac.uk>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 05/15/2017 12:04 PM, Giulio Moro wrote:
> Hi,
> I have a 4.4.61 kernel with Xenomai 3.0.4 on am335x (BeagleBone Black) compiled with 
> 
> CONFIG_BROKEN_ON_SMP=y
> CONFIG_GENERIC_SMP_IDLE_THREAD=y
> CONFIG_HAVE_SMP=y
> # CONFIG_SMP is not set
> (see XENO flags at the bottom of the email)
> 
> When I compile the user-space support with
>     /root/xenomai/configure --with-core=cobalt --enable-smp --enable-pshared
> my program (which uses the Alchemy API) works fine
> 
> But when I do it with
>     /root/xenomai/configure --with-core=cobalt --enable-pshared
> , then calls to rt_task_bind or rt_task_create return -EINVAL.
> 
> Given that SMP is not enabled in the kernel, I would expect the latter to be the correct one and possibly the former to fail.

--enable-smp in user-space entails no interaction with the kernel at
all, this is only a matter of issuing memory barriers in the code flow
to deal with lockless atomic sections.

xeno-config --info would help.

-- 
Philippe.

