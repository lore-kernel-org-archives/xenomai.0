Message-ID: <2ff1a98a0805071052g1515edbam19ad164ce2e53b5d@domain.hid>
Date: Wed, 7 May 2008 19:52:37 +0200
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <6132061f0805071046h65ce2f7eme4fade4c404223a9@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <3d3b73870805061301m4a89029eqa69c17b212274f38@domain.hid>
	<6132061f0805071046h65ce2f7eme4fade4c404223a9@domain.hid>
Subject: Re: [Xenomai-help] Does Xenomai 2.4.x support Xenomm ?
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Breno Carneiro Pinheiro <brenodee@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On Wed, May 7, 2008 at 7:46 PM, Breno Carneiro Pinheiro
 > LDFLAGS := -lnative $(shell $(XENO_CONFIG) --xeno-ldflags)

This should be:

 LDFLAGS := $(shell $(XENO_CONFIG) --xeno-ldflags) -lnative

Order matters.

-- 
 Gilles

