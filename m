Date: Fri, 16 Nov 2018 02:14:39 -0600 (CST)
From: Per Oberg <pero@wolfram.com>
Message-ID: <2015799461.12414544.1542356079122.JavaMail.zimbra@wolfram.com>
Subject: Use of DESTDIR in xeno-config
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai <xenomai@xenomai.org>

Hi everyone

I'm confused over the xeno-config use of DESTDIR and cross-compiling. In th=
e documentation (1) it is claimed that it follows the GNU coding standards.=
=20

Snippet:
"If DESTDIR was set when installing Xenomai - typically after cross-compili=
ng - DESTDIR must be set to the same value before calling xeno-config for a=
ccessing the target-based directories and files from the build system."

The example that is given handles install, and the GNU coding standards (2)=
 also talks about installation. It even specifies: "DESTDIR should be suppo=
rted only in the install* and uninstall* targets, as those are the only tar=
gets where it is useful."

However, xeno-config is hardly used during install.=20

My specific problem boils down to the following:=20
I have built a toolchain for Yocto/Poky that has a xeno-config in the sysro=
ot for the target machine. When using it together with autotools used in th=
e etherlab ethercat master i need to set DESTDIR at configure time so that =
when xeno-config is called the paths to bootstrap.o and dynlib.ld. This fee=
ls wrong because of the above statements.=20

Can anyone enlighten me of the correct way of doing this?

(1) https://xenomai.org/documentation/xenomai-3/html/man1/xeno-config/index=
.html
(2) https://www.gnu.org/prep/standards/standards.html

TTFN
Per =C3=96berg=20

