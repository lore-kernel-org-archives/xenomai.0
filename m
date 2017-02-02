References: <27e6bbb0-cf0c-7a7f-b62c-9ffd7debf400@matrixresearch.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <022a31aa-f24d-4e8e-aec2-7ed93f75c4c9@xenomai.org>
Date: Thu, 2 Feb 2017 11:15:57 +0100
MIME-Version: 1.0
In-Reply-To: <27e6bbb0-cf0c-7a7f-b62c-9ffd7debf400@matrixresearch.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] xenomomai-3 kernel freeze on RPI2
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: John Gwynne <john.gwynne@matrixresearch.com>, xenomai@xenomai.org

On 02/01/2017 07:42 PM, John Gwynne wrote:
> 
> I've been watching for a while for a solution, or even conformation, of
> a potential kernel freeze problem on the Raspberry PI 2/3 platform with
> the Xenomai patches.  Having not seen anything that appears related, I'm
> posting this description of what I've experienced.


Maybe you could try this port. I have only tested the BCM2835
implementation so far, but the pipeline code for supporting the BCM2836
is there too. I have no idea whether it boots though:

http://git.xenomai.org/ipipe.git/log/?h=vendors/raspberry/ipipe-4.1

-- 
Philippe.

