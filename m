Message-ID: <52D5085A.9040607@xenomai.org>
Date: Tue, 14 Jan 2014 10:50:18 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <CAKKWdteq0SUPqv5ecE8V_kAe55pf3GyoYdkJwsrK7JM6=gBaGg@mail.gmail.com>
In-Reply-To: <CAKKWdteq0SUPqv5ecE8V_kAe55pf3GyoYdkJwsrK7JM6=gBaGg@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] real-time taks and signals
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: ali hagigat <hagigatali@gmail.com>, xenomai <xenomai@xenomai.org>

On 01/14/2014 09:49 AM, ali hagigat wrote:
> When a real-time task is in suspend or blocked state, the signals like
> "^C" are caught. While in R state, it seems that it is not seen. Is
> this funtion of Xenomai OK?

Yes. 'R' means ready to run in real-time mode. Real-time threads are 
delivered linux signals only when they block or relax (which is also a 
blocked state Xenomai-wise).

The ROOT thread placeholder maps the entire regular linux context, so in 
that sense, it is always ready to run and may never block from the 
Xenomai point of view.

-- 
Philippe.

