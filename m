Message-ID: <4461B9E8.7000105@domain.hid>
Date: Wed, 10 May 2006 12:01:12 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] T_JOINABLE flag and task creation in userspace
References: <CAD034EB-5B5C-4E38-9C26-BA4D2157C8AA@inquant.de>
In-Reply-To: <CAD034EB-5B5C-4E38-9C26-BA4D2157C8AA@inquant.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Stefan Eletzhofer <stefan.eletzhofer@domain.hid>
Cc: xenomai@xenomai.org

Stefan Eletzhofer wrote:
> Hello,
> I've just tried to create a task in user space with the T_JOINABLE  flag 
> set,
> as I wanted to rt_task_join() to that thread later on.
> 
> Unfortunately, as soon as I set that flag, the task does'nt get started
> at all (i.e. its task body is not reached). Is that a known BUG/ 
> limitation or am I missing
> something? The same program works if I pass 0 instead of T_JOINABLE  (of 
> course the
> rt_task_jolin() fails to join, then, using pause() in that case ;)
> 
> I'm using Xenomai 2.1 on a custom PPC board running a 2.4.25 kernel.  
> The latency tests
> look OKish to me.
> 

A conflict has been detected between the T_JOINABLE bit and the CPU 
affinity bits for the native skin, which caused rt_task_start() to fail 
silently. Fixed in the SVN repository for both the stable and dev 
branches (commits #1062 and #1063).

-- 

Philippe.

