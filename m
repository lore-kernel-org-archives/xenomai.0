Date: Thu, 04 Sep 2008 18:04:45 +0200
From: "Petr Cervenka" <grugh@domain.hid>
MIME-Version: 1.0
Message-ID: <200809041804.16435@domain.hid>
References: 200808251743.26012@domain.hid> <200808251743.26012@domain.hid>
	<48B2DCCC.4010303@domain.hid>
In-Reply-To: <48B2DCCC.4010303@domain.hid>
Content-Type: text/plain; charset="windows-1250"
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai-help] rt_queue_delete returns -EBUSY
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: rpm@xenomai.org
Cc: xenomai@xenomai.org

rpm@xenomai.org wrote:
>Petr Cervenka wrote:
>> Hello,
>> I tried xenomai 2.4.5, hoping that my problems with real-time queue
will disappear. But there is another (perhaps very trivial) error.
>> Function call rt_queue_delete always returns -EBUSY (at least for me).
You don't have to bind it from another task or use it at all.
>> I hope that I have used it in the right way.
>
>Classic chicken-and-egg issue. Ok, will fix.
>
Hello,
I tried to have a look at this issue, but i it perhaps beyond my skills and xenomai knowledge.
I have found in the sources, that the EBUSY is returned by the xnheap_destroy_mapped (probably) because the heap->archdep.numaps still includes actual task/process/whatever.
So there should be some test if the current task isn't (accidentally ;-)) the only referring task. But maybe the fix will be more complex ;-(
Could you please fix it. It's strange that others don't have this problem with the new version...
TIA
Petr


