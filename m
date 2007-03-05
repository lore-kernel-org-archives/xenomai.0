Message-ID: <45ECACFB.9060703@domain.hid>
Date: Tue, 06 Mar 2007 00:51:23 +0100
From: Markus Franke <Markus.Franke@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] rt_pipe_write() returns -ENOMEM
References: <45EC4111.6070104@domain.hid>	<45EC428E.5060306@domain.hid>	<45EC4AF4.7000808@domain.hid>	<45EC4F8E.905@domain.hid>	<45EC5946.9030508@domain.hid>	<45EC61B0.3020907@domain.hid>
	<17900.31172.233075.597047@domain.hid>
In-Reply-To: <17900.31172.233075.597047@domain.hid>
Content-Type: multipart/mixed; boundary="------------040605060806080305050709"
Reply-To: Markus.Franke@domain.hid
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

This is a multi-part message in MIME format.
--------------040605060806080305050709
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Well, I just want to use the RT Pipes as if they are a normal fifo. That
is, the fifo has a bounded amount of memory and if the number of written
bytes exceeds this threshold the data which was firstly written into the
fifo should be dropped. By the way, I am using rt_pipe_write() and
rt_pipe_read() because I just want to exchange simple integer values.

Thanks for help,

Markus Franke

Gilles Chanteperdrix wrote:
> Gilles Chanteperdrix wrote:
>  > Markus Franke wrote:
>  > > OK. And if there is an overflow is there anything I can do during
>  > > runtime, e.g. just to overwrite the data in the queue?
>  > 
>  > Why not something like:
>  > 
>  > while (-ENOMEM == rt_pipe_write(pipe, buf, size, mode)) {
>  > 	RT_PIPE_MSG *msg;
>  > 	rt_pipe_receive(pipe, &msg, TM_INFINITE);
>  > 	rt_pipe_free(pipe, msgp);
>  > }
> 
> This will not work: pipe are a two-ways communication channel, so that
> calling rt_pipe_receive returns messages that were sent from
> user-space, and not the messages previously sent with rt_pipe_write. I
> am afraid what you want to do is not what rt pipes were designed for.
> 

-- 
Nichts ist so praktisch wie eine gute Theorie!

--------------040605060806080305050709
Content-Type: text/x-vcard; charset=utf-8;
 name="Markus.Franke.vcf"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="Markus.Franke.vcf"

begin:vcard
fn:Markus Franke
n:Franke;Markus
adr;quoted-printable:;;Vettersstra=C3=9Fe 64/722;Chemnitz;Saxony;09126;Germany
email;internet:Markus.Franke@domain.hid
x-mozilla-html:FALSE
url:http://www.tu-chemnitz.de/~franm
version:2.1
end:vcard


--------------040605060806080305050709--

