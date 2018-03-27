MIME-Version: 1.0
From: Pintu Kumar <pintu.ping@gmail.com>
Date: Tue, 27 Mar 2018 22:08:20 +0530
Message-ID: <CAOuPNLhC=f01Fa-fZ9SFCsroBq14m9059PMFe9he9Jd_m3p=5g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Xenomai] Debug prints inside xenomai library code
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Xenomai@xenomai.org" <xenomai@xenomai.org>

Hi,

How to add our own debug printf statements inside xenomai library
function, in order to debug something. ?
When I add some printf/rt_printf/fprintf(stderr) statements, it never
get printed on console.
We even tried with --enable-debug=full flag but it did not help.

It looks like standard input/output calls are disabled.
If there is any option to enable it, please let me know.


Thanks,
Pintu

