Message-ID: <479B52CF.6010306@domain.hid>
Date: Sat, 26 Jan 2008 16:33:35 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <4e0b9cb00801240505y77d71956w994e312be382f91b@domain.hid>
In-Reply-To: <4e0b9cb00801240505y77d71956w994e312be382f91b@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-core] Some beginner technical questions
Reply-To: rpm@xenomai.org
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Remi Lefevre <rlefevre@domain.hid>
Cc: xenomai@xenomai.org

Remi Lefevre wrote:
> 
> I saw on some introduction slides that an arinc 653 skin would be possible.
> Emulating the arinc 653 is certainly possible, but if a real arinc 653
> system is considered, this raises a few technical issues.

Issues related to software certification for use in mission critical
contexts such as avionics are well beyond the sole Adeos/Xenomai layer;
firstly, we depend on Linux which would represent quite a job to
certify, not to speak of the toolchains used to build the software which
would need to be certified as well.

Therefore, it seems more reasonable to consider Arinc653 over Xenomai
for emulation duties, i.e. allow developers to implement (most of) their
applications over the APEX in a cosy Linux environment, before banging
anyone's head on the real target is ever needed. What Xenomai could
bring in the picture is accurate emulation, regarding both the APEX
behaviour and timeliness.

In that respect, what should be said about Xenomai regarding Arinc653 is
that the building blocks provided by the former would be enough to
properly emulate the latter (including temporal partitioning).

-- 
Philippe.

