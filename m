Message-ID: <47190.155.98.4.39.1149199741.squirrel@domain.hid>
In-Reply-To: <447F5935.4090105@domain.hid>
References: <39142.155.98.4.39.1149186052.squirrel@domain.hid>	<17535.18007.179715.207040@domain.hid>	<447F49C8.4090609@domain.hid>
	<39455.155.98.4.39.1149195102.squirrel@domain.hid>
	<447F5935.4090105@domain.hid>
Date: Thu, 1 Jun 2006 16:09:01 -0600 (MDT)
Subject: Re: [Xenomai-help] xnpod help
From: "Brandt Erickson" <brandt@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: 8bit
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org

> Ok, things get clearer. But why a kernel module? Are you *that* short on
> CPU cycles?

The reason why I'm trying to develop a kernel-space application is not for
latency issues but because I need to be in kernel-space to read/write
to/from my DAC.  Is the IPC between kernel-space realtime and user-space
non-realtime that much more difficult the user-space realtime to
user-space non-realtime?  I've familiar with regular user-space IPC using
condition variables, semaphores, and shared memory, so if it's fairly
similar, I'm hoping that won't be a problem.
-Brandt


