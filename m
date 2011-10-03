Message-ID: <4E897394.5080304@domain.hid>
Date: Mon, 3 Oct 2011 10:34:28 +0200
From: Michael Bernhard <michael.bernhard@domain.hid>
MIME-Version: 1.0
References: <4E89662E.9090104@domain.hid> <4E897039.30002@domain.hid>
In-Reply-To: <4E897039.30002@domain.hid>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Xenomai configure option --enable-arm-tsc
	in	Xenomai-2.6
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 10/03/2011 10:20 AM, Gilles Chanteperdrix wrote:
> --enable-arm-tsc DOES NOT behave like the old option --enable-arm-arch.
> Hence the rename.
For me, doing the transition form Xenomai-2.5 to 2.6, it was just 
confusing that --enable-arm-tsc has exactly the same help text as the 
old --enable-arm-arch. It would be probably good to add an additional 
sentence to explain why one has to select the architecture for this 
option. Something like this:

"To enable the correct TSC user-space implementation, select for which ..."

--
Michael


