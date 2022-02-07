Message-ID: <50001721-2dfc-3508-bc48-068a9f2eaf23@siemens.com>
Date: Mon, 7 Feb 2022 08:24:16 +0100
MIME-Version: 1.0
Subject: Re: Can mode switches of one thread effect realtime of other xenomai
 threads?
Content-Language: en-US
References: <001a01d819b5$32589230$9709b690$@gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <001a01d819b5$32589230$9709b690$@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Kristian Rahbek <kri.rahbek@gmail.com>, xenomai@xenomai.org

On 04.02.22 11:51, Kristian Rahbek via Xenomai wrote:
> Hello,
> 
> We are running Xenomai 3 with Cobalt kernel.
> We have a realtime xenomai userspace application (which is driven by a RTDM), it runs with the highest priority and doesn't have any mode switches. Let's call it thread 'A'.
> Reading the documentation it's unclear to us, if it can have any ill-effects on the realtime performance of thread A, if the process which spawns thread A has other Xenomai threads, which do have mode switches.
> Is that the case?
> What about separate processes with Xenomai threads, if those have switches between primary and secondary mode (MSW's), can that have any effect on the realtime performance of thread A?
> 

Mode switches are effectively context switches which involve a short
uninterruptible section. But in that regard they are not worth than
switching between two RT tasks while a third, highest prio task is
getting ready.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

