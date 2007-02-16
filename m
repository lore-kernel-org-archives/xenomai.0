Subject: Re: [Xenomai-help] fata: removing non-linked element...
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <45D5F0AD.9010404@domain.hid>
References: <45CC651C.6060402@domain.hid>	<45CC68F3.1000003@domain.hid>
	<45D1C033.9010002@domain.hid>	<45D1C61B.7030503@domain.hid>
	<1171376742.885.3.camel@domain.hid>	<45D1CAFA.6050408@domain.hid>
	<1171385716.885.17.camel@domain.hid>	<45D200C3.1030001@domain.hid>
	<1171393088.885.37.camel@domain.hid>	<45D59F98.8020006@domain.hid>
	<45D5E493.4080405@domain.hid>  <45D5F0AD.9010404@domain.hid>
Content-Type: text/plain
Date: Fri, 16 Feb 2007 19:15:24 +0100
Message-Id: <1171649724.10479.12.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Reply-To: rpm@xenomai.org
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

On Fri, 2007-02-16 at 18:58 +0100, Jan Kiszka wrote:
> Jan Kiszka wrote:
> > ...
> > /me now watching what happens at 10 kHz...
> 
> Bad news are sometimes good news:
> 
> # ./main
> # rmmod xeno_native
> # modprobe xeno_native
> # ./main
> 
> > [  629.916921] Xenomai: stopping RTDM services.
> > [  632.954058] Xenomai: stopping native API services.
> > [  641.763276] Xenomai: starting native API services.
> > [  643.849294] BUG: unable to handle kernel paging request at virtual address c484eb58
> > [  643.857099]  printing eip:
> > [  643.859835] c013a173
> > [  643.862050] *pde = 03fdb067
> > [  643.864868] *pte = 00000000
> > [  643.867696] Oops: 0000 [#1]
> > [  643.870517] PREEMPT
> > [  643.872747] Modules linked in: xeno_native 8139too eepro100 sd_mod scsi_mod
> > [  643.879873] CPU:    0
> > [  643.879884] EIP:    0060:[<c013a173>]    Not tainted VLI
> > [  643.879904] EFLAGS: 00013046   (2.6.19.3 #28)
> > [  643.891932] EIP is at xnheap_init_mapped+0x144/0x1a8

I've just found an issue which caused rt_queue_delete() to leave
dandling mmapped segments when attempting to remove a busy queue (i.e.
still bound to another descriptor in user-space).

Could you resync with v2.3.x (or trunk) head revision and try again?
TIA,

-- 
Philippe.



