Message-ID: <54B69223.2080105@xenomai.org>
Date: Wed, 14 Jan 2015 10:58:27 -0500
From: Jorge Ramirez Ortiz <jro@xenomai.org>
MIME-Version: 1.0
References: <BLU177-W51CD73CBF35D42593C1886A0410@phx.gbl>
In-Reply-To: <BLU177-W51CD73CBF35D42593C1886A0410@phx.gbl>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Analogy - Digital input change detection on falling
 or rising edge (NI PCI6229)
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 01/14/2015 10:44 AM, Rosali Pyun wrote:
> Hello to all,
> I am using NI m-series DAQ card (PCI 6229), and I would like to use digital input channel to detect a change on falling or rising edge.I need to detect the edge and trigger it to log the exact time.I tried to configure the digital channel using instruction as the following, but I received -22 error code.
> insn.type      = A4L_INSN_CONFIG;insn.idx_subd  = SUBD_DIO;insn.chan_desc = 0;insn.data_size = sizeof(data[0])*3;data[0] = A4L_INSN_CONFIG_CHANGE_NOTIFY;data[1]=0x01;data[2]=0x01;insn.data      = data;


could you send a code snippet and details about the xenomai version that you are
running?


> The DAQ card datasheet states that such functionality is supported, but I read couple of posts on Comedi forum that it is not supported for ni_pcimio in Comedi.Is it really impossible to use the digital input channel as an interrupt on Analogy driver?
> If anyone has tried it, could you give me some tips on configuring it?I appreciate any help that I receive.
> Best,Rosali  		 	   		  
> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> http://www.xenomai.org/mailman/listinfo/xenomai
> 

- -- 
jro
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQEcBAEBAgAGBQJUtpIfAAoJECDcy2IJkagRlp4H/ipgRb62sKzJeVmf1EOOkyYG
l1VBtvNr+jcLCS5J0BvMj8AvwWICJzEqp76tNgmflFCKEB/jMLaLqXrHsbolN5wv
OJhgcyBmwr19ODkETjRcBA+KKDMsBDiQ3OahkKZozQTysR46eDTH0sd3LcCRVNxA
C7ty/BGL/6PlrV3TaHDZgDNHrMKcI6MpsVqt5+evczDGxONGWCFiKMAaPu+y6nc2
q+ljz1OefqGUIDtcORWb5RPi6xCq+4+iNwc2osywSgWu/UwABqRqSXQ5QgE3n17f
EUjhs8+ygaZl8fNxj2aN1DkpKABiYmoEC/x78qwrkG+u2jccMLJ2KKvrd30nVDc=
=DaqH
-----END PGP SIGNATURE-----

