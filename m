From: Alexis Berlemont <alexis.berlemont@domain.hid>
Subject: Re: [Adeos-main] [OLDGEN] adeos r17 patch for 2.4.27
Date: Thu, 10 Nov 2005 00:38:00 +0100
References: <Pine.LNX.4.63.0510280949010.31574@domain.hid>
In-Reply-To: <Pine.LNX.4.63.0510280949010.31574@domain.hid>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200511100038.00478.alexis.berlemont@domain.hid>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: adeos-main@gna.org

Hi,

Sorry for answering so late. 

> I was encountering the gcc-3.4 problem when trying to compile rtai on
> a 2.4.27 kernel with the adeos r16 patch included with rtai.
> <https://mail.rtai.org/pipermail/rtai/2005-March/010819.html>
> and
> <https://mail.rtai.org/pipermail/rtai/2005-March/010701.html>
>
> As I understood, this problem has been fixed in r17.  I found this
> announcement <https://mail.rtai.org/pipermail/rtai/2005-March/010821.html>,
> but the r17 patches seem to have dissappeared from download.gna.org?
>
> Is it better to use the r18c1 candidate instead (speaking OLDGEN
> patches, that is)?  Or maybe, more appropriately, has development for
> adeos 2.4 patches stopped with r18c1?

The adeos 2.4 branch development has not been stopped but all the 
modifications from the adeos 2.6 branch are not backported to 2.4.

The reason is not lack of time (but it could be), it is just not necessary 
considering the use of this patch branch (kilauea, vesuvio,... but not 
xenomai).

The candidate release 18 was released at least two months ago. You can use it. 
It can be considered as stable. I have not noticed any problem reported. I am 
working on something else this moment, I still have not found the time to 
update the r18c1 patches to stable; but it will be done.

Regards.

Alexis.


