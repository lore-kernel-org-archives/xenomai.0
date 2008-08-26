Date: Tue, 26 Aug 2008 10:07:08 +0200
From: "Petr Cervenka" <grugh@domain.hid>
MIME-Version: 1.0
Message-ID: <200808261007.17504@domain.hid>
References: 0808251743.26012@domain.hid> <200808251743.26012@domain.hid>
	<48B2E323.1060600@domain.hid> <200808260929.2847@domain.hid>
	<200808260935.5720@domain.hid>
In-Reply-To: <200808260935.5720@domain.hid>
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

>Petr Cervenka wrote:
>> Hello,
>> I tried xenomai 2.4.5, hoping that my problems with real-time queue
will disappear. But there is another (perhaps very trivial) error.
>> Function call rt_queue_delete always returns -EBUSY (at least for me).
You don't have to bind it from another task or use it at all.
>> I hope that I have used it in the right way.
>
>Actually, if your code still creates and deletes queues dynamically
during the
>normal operations, this is clearly not the best approach. Those calls are
VERY
>costly, and very much prone to unbounded latency.
>
>I.e. They switch to secondary mode, allocate/deallocate ranges of kernel
memory,
>create/delete internal Xenomai heap objects, and eventually map/unmap
those
>memory ranges to/from your user-space process.

Dynamic creation of the queues is used only on time non-critical path (client connection, reconfiguration, ...).
I use one central queue and a listening server.
Then I have a set o clients which try to connect to the server. They create input and output queues  and send its identifiers to the server through the central queue.
Server binds those queues (in slow task ) and start to send and receive data  (in fast task).
Similar system is used for reconfiguration, spec. commands, etc..
Only the slow tasks are involved (I hope so).
Petr Cervenka

>-- 
>Philippe.
>


