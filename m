Message-ID: <48635CB3.6000606@domain.hid>
Date: Thu, 26 Jun 2008 11:09:07 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <1214406057.48625da9bf316@domain.hid>	<200806260033.15193.berlemont.hauw@domain.hid>
	<Pine.LNX.4.64.0806260935460.11764@domain.hid>
In-Reply-To: <Pine.LNX.4.64.0806260935460.11764@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Comedi over RTDM
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
To: Klaas Gadeyne <klaas.gadeyne@domain.hid>
Cc: xenomai@xenomai.org

Klaas Gadeyne wrote:
> Hi Alexis,
> 
> On Thu, 26 Jun 2008, Alexis Berlemont wrote:
> [...]
>> Eventually (at last), the "comedi-rtdm-dev" branch reached a stable state (a
>> few weeks ago). The "comedi-rtdm-dev" consists of a kernel framework and a
>> user-space library. Right now, the critical issue is the recovery of the
>> original Comedi drivers. And, more critically, the integration of new drivers
>> for new devices.
> 
> Is your port xenomai-version independent yet?  Or maybe better, which version do you use to test things?
> 

Sidenote: there is a plan to have Alex's work merged into the upcoming 2.5. This
will allow us to complete the jigsaw puzzle on the Xenomai side, paving the way
to a comprehensive RTDM-based real-time device driver suite.

-- 
Philippe.

