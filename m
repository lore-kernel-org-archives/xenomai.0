Message-ID: <5264FD93.2070705@xenomai.org>
Date: Mon, 21 Oct 2013 12:10:27 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <BLU0-SMTP361A4801D1D3A47014E894BAF010@phx.gbl>
In-Reply-To: <BLU0-SMTP361A4801D1D3A47014E894BAF010@phx.gbl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Help with the histogram of latency test
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Chiara <chiaracapretti@hotmail.it>
Cc: xenomai@xenomai.org

On 10/21/2013 07:48 AM, Chiara wrote:
> Hi,
> I'm new of xenomai.
> I would analyze latency performance on different architecture and I want to use the histogram that latency produce with the option -g.
> But when I use the script histo.gp I visualize this warning message:
> "skipping unreadable file, no data in plot"
>
> I write this command
>
> gnuplot -e 'input_file="/usr/xenomai/bin/.latency -t1 - g gr ";output_file="/usr/xenomai/bin/gr";graph_title="graph";' /usr/xenomai/bin/histo.gp

The input file of the histo.gp script is the output file you obtained 
with latency -g. The output file is the file where you want the script 
to put the generated image.

-- 
					    Gilles.

