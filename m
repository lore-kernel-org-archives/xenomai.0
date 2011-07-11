Message-ID: <4E1ADEA7.30003@domain.hid>
Date: Mon, 11 Jul 2011 13:29:43 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAG1VJdr9-_WbBTg+L7tAT8+aGOM7oH844F3NfcRmQrHLcCvpAw@domain.hid>
In-Reply-To: <CAG1VJdr9-_WbBTg+L7tAT8+aGOM7oH844F3NfcRmQrHLcCvpAw@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Compiling Library files over Xenomai
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Ashish Budhiraja <ashishmach@domain.hid>
Cc: xenomai@xenomai.org

On 07/08/2011 02:10 PM, Ashish Budhiraja wrote:
> Hello Everyone,
> 
> I am using Roboard (RB-100) on which I have Xenomai installed. All the
> example files are working fine and
> I have internet through wifi and lan both.
> 
> 
> Roboard comes with normal C & C++&header files in a folder called
> roboard_lib. These files are for IO, pwm, spi, i2c etc....Actually I am
> having trouble with compiling and linking the roboard_lib files.
> 
>  If anyone can help me to edit makefile to compile a library please reply.
> Because I tried a lot with the makefile available with examples files, but
> couldn't succeed.
> 
> The errors which I am getting:
> 
> 1) I think somehow my gcc doesn't accept "bool" so I had to include
> stdbool.h,,,it works now.
> 2) I am getting errors like *undefined reference to "SOMEfunction" *...this
> I think this is because my library files are not compiling.
> 
> Thanks a lot ,,,,please guide me through this....if someone can show me
> their MAKEFILE(with library compiled) it would be a great help.

You do not give us any detail, so, I am going to give you a very general
advice, which may, or may not be what you are looking for.

To compile and link xenomai applications, you should use xeno-config to
obtain the flags.

If you are using the posix skin,  you should use

xeno-config --skin posix --cflags
to obtain the compilation flags.

and
xeno-config --skin posix --ldflags
to obtain the flags for linking.


-- 
                                                                Gilles.

