Message-ID: <2ff1a98a0805130159nced5924o22d89c4d359cd1e0@domain.hid>
Date: Tue, 13 May 2008 10:59:28 +0200
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <749025575@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <749025575@domain.hid>
Subject: Re: [Xenomai-help] Cross-Compile Xenomai
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Joachim Meyer <Jogi95@domain.hid>
Cc: xenomai@xenomai.org

On Tue, May 13, 2008 at 10:53 AM, Joachim Meyer <Jogi95@domain.hid> wrote:
>  Can I crosscompile Xenomai without root privileges?

make DESTDIR=`pwd`/inst install

Will create a local inst directory and install everything there.

-- 
 Gilles

