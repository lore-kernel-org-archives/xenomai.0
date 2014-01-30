Message-ID: <52EA81A1.4000305@xenomai.org>
Date: Thu, 30 Jan 2014 17:45:21 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
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
 <1391088235.30999.YahooMailNeo@web163901.mail.gq1.yahoo.com>
In-Reply-To: <1391088235.30999.YahooMailNeo@web163901.mail.gq1.yahoo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 01/30/2014 02:23 PM, Huub Van Niekerk wrote:
> I've added the mkdir's I thought were necessary. However, what I don't
> understand is the message "ERROR: ld.so: object 'libfakeroot-sysv.so'
> from LD_PRELOAD cannot be preloaded: ignored". After this it asks for
> the sudo password. After that the error message shows again, the script
> goes on shortly and ends in the "cannot create directory" error. Do you
> have any idea what the cause of the ld.so error may be ?

It is caused by fakeroot, you can ignore that.


-- 
					    Gilles.

