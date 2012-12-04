MIME-Version: 1.0
In-Reply-To: <50BC705D.2040407@xenomai.org>
References: <CAL7_A_WEXhEBQr+LFb_mfaqLxBh=hsHJg6WiY08cmkgb=Y2TNA@mail.gmail.com>
	<4FF369E5.5040007@xenomai.org>
	<CAL7_A_WYVjFhh9RuxAm1jtVp7HqakB5gEzkSt8i7XsWJNJrh=Q@mail.gmail.com>
	<4FF402AD.3020601@xenomai.org> <4FF415AB.2030503@xenomai.org>
	<CAL7_A_Xr432pEEEiG4D5xsD-2yqWdgSd0tD26aEi4q0FzeWD_w@mail.gmail.com>
	<CAL7_A_XMD_KY9nryEyb3xzHpCb1PFYTG6qJupLWqRZhJXjkYRw@mail.gmail.com>
	<4FF44389.3030209@xenomai.org>
	<CAL7_A_WTJUeWNTTra2t9veiyWMxC5VtpotocMHGPdU1v7QAxKA@mail.gmail.com>
	<4FF44C52.6050809@xenomai.org>
	<CAL7_A_VUC8JD9yeMnLt2iJQ0ex_at3QMhiL3cQ5CHPFh0rcJRA@mail.gmail.com>
	<4FF585C4.1000708@xenomai.org>
	<CAL7_A_WZ=mQ9F_Od92qQKFS85QcOtOwqyXu+omrhOBgnZpJFNQ@mail.gmail.com>
	<50AA3732.5000701@xenomai.org>
	<CAL7_A_VBCVX9o4_m4DEH7iDAf423UiowDGy+FhD_VZLcfonq9g@mail.gmail.com>
	<50BC705D.2040407@xenomai.org>
Date: Tue, 4 Dec 2012 11:09:05 +0100
Message-ID: <CAL7_A_UE2siUJTMcWnJiJz4y0=PhcEM-Y6dJsnY5XwdgW12_ig@mail.gmail.com>
From: =?ISO-8859-1?Q?Jens_K=F6hler?= <jenskxxx@googlemail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [Xenomai] Xenomai and normal linux application - Wait time with
 select() not reliable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

Hi,

> If you expect a task using a Linux semaphore to have bounded latencies,
> you misunderstood the way Xenomai works.

I have not so a deep knowledge about linux semaphores and xenomai. A
linux semaphore controls access to a linux shared memory. The Xenomai
task is the only task which writes to shared memory. Several linux
applications reading from shared memory. The task of semaphore is to
prevent that during data reading the Xenomai task could write to
shared memory. I understand Xenomai has highest priority. What does
xenomai/ linux when xenomai task tries to write to shared memory, but
semaphore blocks writing?

best regards,
Jens

