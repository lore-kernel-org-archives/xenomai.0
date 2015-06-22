Message-ID: <55884BB1.3020800@xenomai.org>
Date: Mon, 22 Jun 2015 19:53:53 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <1434988133.67288.YahooMailBasic@web173201.mail.ir2.yahoo.com>
In-Reply-To: <1434988133.67288.YahooMailBasic@web173201.mail.ir2.yahoo.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] include guard trank/posix/pthread.h
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Frederik Bayart <frederik_bayart@yahoo.co.uk>, xenomai@xenomai.org

On 06/22/2015 05:48 PM, Frederik Bayart wrote:
> --- rules.old	2015-06-22 17:41:21.192669068 +0200
> +++ rules.new	2015-06-22 17:45:31.916677507 +0200
> @@ -64,6 +64,9 @@
>  	for f in $(CURDIR)/kernel/cobalt/udev/*.rules ; do \
>  	    cat $$f >> $(CURDIR)/debian/libxenomai1/etc/udev/xenomai.rules ; \
>  	done
> +	# xeno-config should be only in xenomai-runtime
> +	rm -f $(CURDIR)/debian/libxenomai-dev/usr/bin/xeno-config
> +	rm -f $(CURDIR)/debian/libxenomai-dev/usr/share/man/man1/xeno-config.1
>  	install -m 644 debian/libxenomai1.modprobe $(CURDIR)/debian/libxenomai1/etc/modprobe.d/xenomai.conf
>  	# remove empty directory
>  	rm -rf $(CURDIR)/debian/xenomai-doc/usr/share/doc/xenomai-doc/ps

Merged, thanks.

-- 
Philippe.

