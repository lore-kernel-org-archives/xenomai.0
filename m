Date: Sat, 29 Aug 2015 19:21:47 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150829172147.GG20679@hermes.click-hack.org>
References: <8655AC8285F53F42A4B1B3CAB3092C47235FC2D7@IVKEX2.fkfs.de>
 <8655AC8285F53F42A4B1B3CAB3092C47235FD2F2@IVKEX2.fkfs.de>
 <8655AC8285F53F42A4B1B3CAB3092C47235FD31D@IVKEX2.fkfs.de>
 <20150829154617.GF20679@hermes.click-hack.org>
 <8655AC8285F53F42A4B1B3CAB3092C47235FD340@IVKEX2.fkfs.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8655AC8285F53F42A4B1B3CAB3092C47235FD340@IVKEX2.fkfs.de>
Subject: Re: [Xenomai] Question about priority coupling in primary and
 secondary mode
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Rothermel, Thomas" <Thomas.Rothermel@fkfs.de>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On Sat, Aug 29, 2015 at 04:12:19PM +0000, Rothermel, Thomas wrote:
> Gilles, thank you very much for your fast reply. 
> 
> >> Furthermore I can't use RTnet, because all other network nodes
> >> don't use it.
> 
> >That is a wrong reason not to use RTnet.
> 
> Ok does that mean that it is possible combining RTnet and non
> RTnet network nodes? That would solve my problem. If the answer is
> yes, I couldn't figure out how to configure RTnet to send standart
> UDP messages.

As far as I know RTnet UDP messages are standard UDP messages, but I
never tried the TDMA access control. With the nomac access control,
you only get non standard messages when using the non real-time
interface attached to a real-time interface. And you can even avoid
that if you use the RTnet proxy.

> Do I have to load the rt version of my network card
> driver?

Well, yes, obviously. As well as the rtnet, rtipv4 and rtudp
modules.

-- 
					    Gilles.
https://click-hack.org

