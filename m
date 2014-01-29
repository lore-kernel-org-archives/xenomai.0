Message-ID: <52E950FB.70400@xenomai.org>
Date: Wed, 29 Jan 2014 20:05:31 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <1391006203.6916.YahooMailNeo@web163902.mail.gq1.yahoo.com>
In-Reply-To: <1391006203.6916.YahooMailNeo@web163902.mail.gq1.yahoo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] debuild of xenomai failing: Directory nonexistent
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Huub Van Niekerk <huubvanniekerk@yahoo.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 01/29/2014 03:36 PM, Huub Van Niekerk wrote:
> Hi,
> 
> I'm trying to build the xenomai libs on Ubuntu 12.04 armhf according
> to http://www.xenomai.org/index.php/Building_Debian_packages. It goes
> wrong with a message "cannot create
> <user>/Downloads/xenomai-2.6.3/debian/libxenomai1/etc/udev//xenomai.rules:
> Directory nonexistent". Any idea what the cause of this is ? I did it
> before on x86, which went great.

I do not see why this even works on x86... Please try the following 
patch:

diff --git a/debian/rules b/debian/rules
index 3915fd6..280442f 100755
--- a/debian/rules
+++ b/debian/rules
@@ -66,6 +66,7 @@ install: build
 	# xeno-config should be only in libxenomai-dev
 	rm -f $(CURDIR)/debian/xenomai-runtime/usr/bin/xeno-config
 	rm -f $(CURDIR)/debian/xenomai-runtime/usr/share/man/man1/xeno-config.1
+	mkdir -p $(CURDIR)/debian/libxenomai1/etc/udev/
 	for f in $(CURDIR)/ksrc/nucleus/udev/*.rules ; do \
 	    cat $$f >> $(CURDIR)/debian/libxenomai1/etc/udev/xenomai.rules ; \
 	done


> 
> Thanks _______________________________________________ Xenomai
> mailing list Xenomai@xenomai.org 
> http://www.xenomai.org/mailman/listinfo/xenomai
> 


-- 
                                                                Gilles.

