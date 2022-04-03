import { expect } from "chai";

export function shouldBehaveLikeElection(): void {
  it("should place a vote", async function () {
    const candidate = 0;
    void expect(await this.election.connect(this.signers.admin).placeVote(candidate))
      .to.emit(this.election, "Vote")
      .withArgs(candidate);
  });

  it("should revert when trying to vote for the second time", async function () {
    const candidate = 0;
    await expect(this.election.connect(this.signers.admin).placeVote(candidate)).to.be.revertedWith(
      "You can only vote once!",
    );
  });
}
