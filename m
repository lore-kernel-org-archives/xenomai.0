Date: Mon, 20 Jan 2020 09:01:44 +0100
From: Henning Schild <henning.schild@siemens.com>
Subject: RFC: making dlopen support default on for debian/rules
Message-ID: <20200120090144.1d93b807@md1za8fc.ad001.siemens.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>

Hi all,

i do carry a local patch to make the debian packages dlopen-aware for
quite some time now. It used to be that debian packaging was not well
supported and just carried for reference.
But with the rise of Isar in the building Xenomai world the current
view on the debian/ support might change.

What are your thoughts on putting "--enable-dlopen-libs" into
debian/rules? I would be happy to send a patch.

regards,
Henning

