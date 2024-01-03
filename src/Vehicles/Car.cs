// <copyright file="Car.cs" company="MyCompany">
// Copyright (c) MyCompany. All rights reserved.
// </copyright>

namespace Vehicles;

/// <summary>
/// Defines the <see cref="Car" />.
/// </summary>
public class Car : IVehicle
{
    private bool isStarted = false;

    /// <inheritdoc/>
    public void Start()
    {
        this.isStarted = true;
    }

    /// <inheritdoc/>
    public void Drive()
    {
        if (!this.isStarted)
        {
            throw new InvalidOperationException("You must start the car before driving it.");
        }
    }
}
