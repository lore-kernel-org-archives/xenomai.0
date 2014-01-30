Message-ID: <52EA0FDF.6040604@xenomai.org>
Date: Thu, 30 Jan 2014 09:39:59 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <1391006203.6916.YahooMailNeo@web163902.mail.gq1.yahoo.com>
 <52E950FB.70400@xenomai.org> <52E95E66.2060905@xenomai.org>
 <1391067115.6898.YahooMailNeo@web163904.mail.gq1.yahoo.com>
In-Reply-To: <1391067115.6898.YahooMailNeo@web163904.mail.gq1.yahoo.com>
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

On 01/30/2014 08:31 AM, Huub Van Niekerk wrote:
> I assume I have to save this patch into a textfile (e.g. debuild-patch) and use the patch command: patch debuild debuild-patch ?

Type:
cd <user>/Downloads/xenomai-2.6.3
patch -p1 < /path/to/debuild-patch


-- 
                                                                Gilles.

