Message-ID: <50260DCB.90401@xenomai.org>
Date: Sat, 11 Aug 2012 09:46:19 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] Using asciidoc for README.INSTALL
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <Xenomai@xenomai.org>


Hi,

currently, the installation instructions are available on xenomai
website as a plain text file. It makes sense, as we want them as a plain
text file in the release tarball, and we do not want to maintain two
separate sets of installation instructions. However, a plain text file
is not so nice to read in a web browser.

So, maybe we could use an asciidoc version. I tried to do a quick
conversion to asciidoc, and I find it looks fine:
http://xenomai.org/~gch/README.INSTALL.html
The sources however, maybe a bit less readable:
http://xenomai.org/~gch/README.INSTALL.txt
But maybe we can ask asciidoc to generate a really plain text version.

Anyone opposed to the change?

pros:
- nice online html version
- online one source file to maintain
cons:
- need to learn asciidoc syntax to maintain the doc
- a slightly less readable plain text version

Regards.

-- 
                                                                Gilles.

