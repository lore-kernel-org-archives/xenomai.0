From: Steven Seeger <steven.seeger@nasa.gov>
Reply-To: <steven.seeger@nasa.gov>
Date: Mon, 8 Oct 2018 15:46:29 -0400
Message-ID: <6875132.RugRrNzuTl@wirbelwind>
In-Reply-To: <29051082.nZQKAztGnQ@lenni>
References: <C2EC5BA46D13CD44B5915A8FEEB4C44ED1819D8C@DDCEXCH.ddc-ny.com>
 <C2EC5BA46D13CD44B5915A8FEEB4C44ED1819FA9@DDCEXCH.ddc-ny.com>
 <29051082.nZQKAztGnQ@lenni>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Subject: Re: [Xenomai] Does RTNET supports TCP?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Sebastian Smolorz <Sebastian.Smolorz@gmx.de>
Cc: "Pham, Phong" <phamp@ddc-web.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>, "Hillman, Robert" <hillman@ddc-web.com>

On Monday, October 8, 2018 2:49:55 PM EDT Sebastian Smolorz wrote:
> 
> Hm ... then why don't you fetch your files in non-realtime context? This
> would be much easier I suppose.

Yes I agree. Based on what Phong has said, it would make more sense to fetch 
the files in a non-realtime context and then use some realtime primitive (e.g., 
pipe) to send any data from those files to a necessary realtime context.

Steven




