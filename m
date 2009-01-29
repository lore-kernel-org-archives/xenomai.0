Message-ID: <49815710.7070709@domain.hid>
Date: Thu, 29 Jan 2009 08:13:20 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <ba9b368a0901282227i705ebe80oe75782ccc5cdc17f@domain.hid>	
	<49814ED3.9080607@domain.hid>
	<ba9b368a0901282246t4bece718g5b8512220e961719@domain.hid>
In-Reply-To: <ba9b368a0901282246t4bece718g5b8512220e961719@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Problem using sem_open and rt_sem_create
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Daniel Adams <dadams81@domain.hid>
Cc: xenomai@xenomai.org

Daniel Adams wrote:
> Thanks Gillies,
> 
> Is it possible to use the rt_sem_bind from a linux process that hasn't been
> shadowed using rt_task_shadow?

No. If you read the documentation of rt_sem_bind, you will see:

Environments:

This service can be called from:

    * User-space task (switches to primary mode)

And to switch to primary mode, task needs to be shadowed with
rt_task_shadow.

> Is this the same for named pipes created using the native skin and accessing
> them from a posix interface?

The non real-time side of named pipes may be accessed using the Linux
posix interface, not Xenomai posix skin interface.

> 
> What is the recommended IPC to talk between posix threads and native rt
> threads?

It depends if you are talking about (non real-time) Linux posix threads,
or (real-time) Xenomai posix skin threads.

If you are talking about Linux posix threads, then what you are looking
for is rt_pipes.

If you are talking about Xenomai posix skin threads, then mostly any IPC
of both skins may be used. Only, you have to use the same interface with
both skins. So, for instance, if you choose Xenomai posix skin message
queues, you have to use mq_open, mq_send, mq_receive, mq_close,
mq_unlink with the threads of the two skins.

-- 
					    Gilles.

