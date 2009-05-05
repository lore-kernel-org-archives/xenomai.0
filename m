Message-ID: <49FFF0FA.9070104@domain.hid>
Date: Tue, 05 May 2009 09:55:38 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <296208.73890.qm@domain.hid>
In-Reply-To: <296208.73890.qm@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] shared library in xenomai ?
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: luan dinh <dinhluanbmt@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

luan dinh wrote:
> hi.
> this is my problem :
> i write a program which use raw socket and rteth0 NIC card to send data. when i build  as application it run well. then i build this program as shared libarary named  libctest.so support send() function to send data
> the command to build shared lib similar to :
>     gcc -shared -Wl,-soname,libctest.so.1 -o libctest.so.1.0   *.o
>     mv libctest.so.1.0 /opt/lib
>     ln -sf /opt/lib/libctest.so.1.0 /opt/lib/libctest.so
>     ln -sf /opt/lib/libctest.so.1.0 /opt/lib/libctest.so.1 
> i write a TEST program use the send() function which supported by  my library.
> the command to build TEST program similar to :
> gcc <xenomai options> prog.c -lctest -o TEST
> when i execute by command ./TEST
> the TEST program still run. the send() function seem to be right but no data sent to network adapter

Please post an excerpt of your code exposing this issue (the library
part, and the program part).

You should note that compiling libraries or programs for Xenomai usually
involves compilation flags obtained with xeno-config.

You should also note that "send()" is a glibc function, so calling a
function with the same name is a bad idea.

-- 
                                                 Gilles.

