Message-ID: <2ff1a98a0802070720m35614f33p352bab27380fb93e@domain.hid>
Date: Thu, 7 Feb 2008 16:20:54 +0100
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <51CAD0CE1504444DBE77CBBE51A0135D3769E5@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <51CAD0CE1504444DBE77CBBE51A0135D3769D5@domain.hid>
	<2ff1a98a0802070043n7c78e397i9345f3de1229f6bf@domain.hid>
	<51CAD0CE1504444DBE77CBBE51A0135D3769DF@slcmail.slc.mew.int>
	<DD39B5C3F4963040ADC9768BE7E430CB02AF4D89@domain.hid>
	<51CAD0CE1504444DBE77CBBE51A0135D3769E1@domain.hid>
	<DD39B5C3F4963040ADC9768BE7E430CB02AF4DB5@domain.hid>
	<51CAD0CE1504444DBE77CBBE51A0135D3769E5@domain.hid>
Subject: Re: [Xenomai-help] SIGTRAP
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Steven Seeger <sseeger@domain.hid>
Cc: xenomai@xenomai.org

On Feb 7, 2008 4:18 PM, Steven Seeger
<sseeger@domain.hid> wrote:
> Thanks for the advice. I think I have this stuff set up correctly, but I
> am not really sure what solib-absolute-prefix does so mine is set to
> /dev/null. :)

solib-absolute-prefix should point to where the unstripped libraries,
matching those running on the target, are available. This allows gdb
to debug the libraries.

-- 
                                               Gilles Chanteperdrix

