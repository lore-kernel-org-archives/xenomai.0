Date: Fri, 11 Dec 2015 17:31:14 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20151211163114.GE24775@hermes.click-hack.org>
References: <2004286.fnOG18ZY9A@soho> <5073889.mxMKChqctc@soho>
 <20151211140927.GB24775@hermes.click-hack.org>
 <3314665.2OtX88jxTl@soho>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3314665.2OtX88jxTl@soho>
Subject: Re: [Xenomai] Porting a library to Xenomai
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Leopold Palomo-Avellaneda <leo@alaxarxa.net>
Cc: Xenomai list <xenomai@xenomai.org>

On Fri, Dec 11, 2015 at 04:33:58PM +0100, Leopold Palomo-Avellaneda wrote:
> El Divendres, 11 de desembre de 2015, a les 15:09:27, Gilles Chanteperdrix va 
> escriure:
> [...]
> > > 
> > > No Gilles, that's the point that I don't understand. Maybe it could be a
> > > language problem.
> > 
> > If you do not understand the text. Read the example.
> 
> what I'm worried about if theses wraps implies more things that are hidden. 
> The example is clear. Maybe I'm imagine more things that really
> exists.

The fact that wrapping may be a problem for large applications where
you only want a small part of the application to use xenomai
services is the reason why Xenomai 3.x gives you another choice: do
not wrap xenomai services, but specify you want to use them with the
__RT() macro.

-- 
					    Gilles.
https://click-hack.org

