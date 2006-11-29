Message-ID: <456D5399.4040901@domain.hid>
Date: Wed, 29 Nov 2006 10:32:09 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Re: [RFC][PATCH 1/2] rework shadow CPU affinity
References: <456C3EF9.30102@domain.hid> <456C8961.7060906@domain.hid>
	<456C97B9.1000402@domain.hid> <456D4C7D.2040100@domain.hid>
	<456D4ED4.5040405@domain.hid>
In-Reply-To: <456D4ED4.5040405@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
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
Cc: xenomai-core <xenomai@xenomai.org>

Jan Kiszka wrote:
> OK. So you are suggesting to read out the affinity mask from task_struct
> instead of passing it as an additional argument?
> 

Unless I am wrong, it is the way it currently works.

-- 
                                                 Gilles Chanteperdrix

