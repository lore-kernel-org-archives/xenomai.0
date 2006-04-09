Message-ID: <44390317.6080005@domain.hid>
Date: Sun, 09 Apr 2006 14:50:31 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <4438EB6C.1030607@domain.hid>
In-Reply-To: <4438EB6C.1030607@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] Re: [PATCH] display domain status in I-ipipe tracer
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: adeos-main@gna.org, xenomai-core <xenomai@xenomai.org>

Jan Kiszka wrote:
> Hi,
> 
> as promised, here is the patch to extend the I-ipipe trace so that it
> displays also the domain stall flags of the first 4 domains (I don't
> expect more in practice yet ;) ). The information is shown if you switch
> on the verbose mode (echo 1 > /proc/ipipe/tracer/verbose). Also, more
> explanation of the shown columns is given now.
> 
> Please apply.
> 

Applied, thanks.

-- 

Philippe.

