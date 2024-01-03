// <copyright file="IVehicle.cs" company="MyCompany">
// Copyright (c) MyCompany. All rights reserved.
// </copyright>

namespace Vehicles;

/// <summary>
/// Defines the <see cref="IVehicle" />.
/// </summary>
public interface IVehicle
{
    /// <summary>
    /// Starts the vehicle.
    /// </summary>
    void Start();

    /// <summary>
    /// Drives the vehicle.
    /// </summary>
    void Drive();
}
