References: <1391006203.6916.YahooMailNeo@web163902.mail.gq1.yahoo.com>
 <52E950FB.70400@xenomai.org> <52E95E66.2060905@xenomai.org>
 <1391067115.6898.YahooMailNeo@web163904.mail.gq1.yahoo.com>
 <52EA0FDF.6040604@xenomai.org>
 <1391072739.44037.YahooMailNeo@web163902.mail.gq1.yahoo.com>
 <52EA1A55.3040907@xenomai.org>
 <1391074883.36568.YahooMailNeo@web163905.mail.gq1.yahoo.com>
 <52EA2EDF.2050900@xenomai.org>
 <1391083620.48248.YahooMailNeo@web163903.mail.gq1.yahoo.com>
 <52EA4B35.2090306@xenomai.org>
Message-ID: <1391088235.30999.YahooMailNeo@web163901.mail.gq1.yahoo.com>
Date: Thu, 30 Jan 2014 05:23:55 -0800 (PST)
From: Huub Van Niekerk <huubvanniekerk@yahoo.com>
In-Reply-To: <52EA4B35.2090306@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] debuild of xenomai failing: Directory nonexistent
Reply-To: Huub Van Niekerk <huubvanniekerk@yahoo.com>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

I've added the mkdir's I thought were necessary. However, what I don't unde=
rstand is the message "ERROR: ld.so: object 'libfakeroot-sysv.so' from LD_P=
RELOAD cannot be preloaded: ignored". After this it asks for the sudo passw=
ord. After that the error message shows again, the script goes on shortly a=
nd ends in the "cannot create directory" error. Do you have any idea what t=
he cause of the ld.so error may be ?=0A=0A=0A=0A=0AOn Thursday, January 30,=
 2014 1:53 PM, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org> wrot=
e:=0A =0AOn 01/30/2014 01:07 PM, Huub Van Niekerk wrote:=0A> Thank you. I'v=
e applied the patch as you indicated. Unfortunately,=0A> the build goes wro=
ng. I'd like to send you the file containing the=0A> captured error, but th=
e sending fails (due to the mailing list ?).=0A=0AIf the mailing list refus=
es a message, it should send you an answer=0Atelling you why. Most probable=
 reason would be that you are sending HTML=0Amails, whereas the mailing lis=
t only accepts plain text mails.=0A=0AThe mailing list also "scrubs" the at=
tachments and makes them=0Adownloadable from the archives area, in order to=
 avoid uselessly sending=0Athe attachments to all the subscribers. Those wh=
o are interested can=0Adownload the attachment via http. So, you can direct=
ly make your=0Aattachments available via http, the result will be the same.=
 For logs,=0Athe trend these days is to use pastebin.=0A=0A=0A-- =0A=A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 Gilles.
