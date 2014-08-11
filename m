Message-ID: <53E93A3D.2060403@nta-inc.net>
Date: Mon, 11 Aug 2014 16:48:45 -0500
From: Jeff Webb <jeff.webb@nta-inc.net>
MIME-Version: 1.0
References: <CAEGbdidABiixUba3TiheYcLx1Swh5TrTbt_FtenZsExq7weUYg@mail.gmail.com>
In-Reply-To: <CAEGbdidABiixUba3TiheYcLx1Swh5TrTbt_FtenZsExq7weUYg@mail.gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] C++ std::thread and xenomai pthread
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

On 08/11/2014 10:33 AM, Matthew Lindner wrote:
> Has anyone experimented with using std::thread from the C++ STL library? I
> am curious if it automatically incorporates the xenomai pthread API layer
> or whether it bypasses that and accesses the linux pthread library.

Yes, I've tried this and it has worked for me.

-Jeff



