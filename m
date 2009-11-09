Message-ID: <4AF86533.1050106@domain.hid>
Date: Mon, 09 Nov 2009 19:53:39 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4AF85529.4070308@domain.hid>
In-Reply-To: <4AF85529.4070308@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] Heaps again...
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

Jan Kiszka wrote:
> Philippe,
> 
> having a Xenomai heap mapped and then forking / exiting the fork is not
> a good idea, is it? I mean for the sake of archdep.numaps...

OK, think I found the gremlin: xnheap_vmclose must be paired with a
xnheap_vmopen for proper reference counting, not simple mapping
operations. Will test my theory (actually: Linux Device Drivers'
explanation) and post a patch afterwards.

Jan

-- 
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux

